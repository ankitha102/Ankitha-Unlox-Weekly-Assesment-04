USE bookmart;

SELECT COUNT(*) FROM authors;
SELECT COUNT(*) FROM books;
SELECT COUNT(*) FROM sales;

SHOW TABLES;

-- ============================================
-- SECTION A – THEORY
-- ============================================

-- A1
-- Answer: b

-- A2
-- Answer: c

-- A3
-- Answer: c

-- A4
-- Answer: b

-- A5
-- Answer: b

-- A6
-- Answer: b

-- A7
-- Answer: b

-- A8
-- Answer: b

-- ============================================
-- SECTION B – OUTPUT PREDICTION
-- ============================================

-- B1
-- Answer: 25

-- B2
-- Answer: 0

-- B3
-- Answer: 3

-- B4
-- Answer: 5

-- B5
-- Answer: 13

-- B6
-- Answer: 15

-- B7
-- Answer: 30

-- B8
-- Answer: 4

-- ============================================
-- SECTION C – Applied SQL
-- ============================================

-- C1–C4 → Basic Joins
-- C1 – Basic INNER JOIN

SELECT
    b.title,
    a.name AS author_name
FROM books b
INNER JOIN authors a
    ON b.author_id = a.author_id;
    
    -- C2 – Basic LEFT JOIN

SELECT
    a.name AS author_name,
    b.title
FROM authors a
LEFT JOIN books b
    ON a.author_id = b.author_id;

-- C3 – Total Revenue per Genre

SELECT
    b.genre,
    SUM(s.quantity * b.price) AS revenue
FROM sales s
INNER JOIN books b
    ON s.book_id = b.book_id
GROUP BY b.genre
ORDER BY revenue DESC;

-- C4 – Highest Revenue City

SELECT
    s.city,
    SUM(s.quantity * b.price) AS revenue
FROM sales s
INNER JOIN books b
    ON s.book_id = b.book_id
GROUP BY s.city
ORDER BY revenue DESC
LIMIT 1;

-- C5–C7 → Extended Joins
-- C5 – RIGHT JOIN

SELECT
    b.title,
    a.name AS author_name
FROM authors a
RIGHT JOIN books b
    ON a.author_id = b.author_id;
    
    -- C6 – FULL OUTER JOIN using UNION

SELECT
    a.author_id,
    a.name AS author_name,
    b.book_id,
    b.title
FROM authors a
LEFT JOIN books b
    ON a.author_id = b.author_id
UNION
SELECT
    a.author_id,
    a.name AS author_name,
    b.book_id,
    b.title
FROM authors a
RIGHT JOIN books b
    ON a.author_id = b.author_id;
    
    -- C7 – SELF JOIN

SELECT
    a.name AS author,
    m.name AS mentor
FROM authors a
INNER JOIN authors m
    ON a.mentor_id = m.author_id;
    
    -- C8–C10 → Set Operations
    -- C8 – CROSS JOIN

SELECT
    c.city,
    t.customer_type
FROM
    (SELECT DISTINCT city FROM sales) c
CROSS JOIN
    (SELECT DISTINCT customer_type FROM sales) t;
    
    -- C9 – UNION

SELECT
    name
FROM authors
WHERE country = 'India'
UNION
SELECT
    name
FROM authors
WHERE born_year > 1970;

-- C10 – Anti-Join

SELECT
    b.book_id,
    b.title
FROM books b
LEFT JOIN sales s
    ON b.book_id = s.book_id
WHERE s.book_id IS NULL;

-- C11–C14 → Subqueries
-- C11 – Scalar Subquery

SELECT
    title,
    price
FROM books
WHERE price > (
    SELECT AVG(price)
    FROM books
);

-- C12 – IN with Subquery

SELECT*
FROM sales
WHERE book_id IN (
    SELECT book_id
    FROM books
    WHERE genre IN ('History', 'Mythology')
);

-- C13 – Greater Than ALL

SELECT
    title,
    price
FROM books
WHERE price > ALL (
    SELECT price
    FROM books
    WHERE genre = 'Fiction'
);

-- C14 – Correlated Subquery

SELECT
    b.title,
    b.genre,
    b.price
FROM books b
WHERE b.price > (
    SELECT AVG(b2.price)
    FROM books b2
    WHERE b2.genre = b.genre
);

-- C15–C17 → EXISTS / NOT EXISTS
-- C15 – EXISTS

SELECT
    a.name
FROM authors a
WHERE EXISTS (
    SELECT 1
    FROM books b
    WHERE b.author_id = a.author_id
      AND b.published_year > 2018
);

-- C16 – NOT EXISTS

SELECT
    a.name
FROM authors a
WHERE NOT EXISTS (
    SELECT 1
    FROM books b
    WHERE b.author_id = a.author_id
      AND b.genre = 'Business'
);

-- C17 – IN with Subquery

SELECT*
FROM sales
WHERE book_id IN (
    SELECT
        b.book_id
    FROM books b
    INNER JOIN authors a
        ON b.author_id = a.author_id
    WHERE a.country = 'India'
);

-- C18–C21 → Window Functions
-- C18 – AVG() OVER(PARTITION BY)

SELECT
    title,
    genre,
    price,
    AVG(price) OVER (
        PARTITION BY genre
    ) AS avg_genre_price
FROM books;

-- C19 – ROW_NUMBER()

SELECT
    title,
    genre,
    price
FROM (
    SELECT
        title,
        genre,
        price,
        ROW_NUMBER() OVER (
            PARTITION BY genre
            ORDER BY price DESC
        ) AS rn
    FROM books
) ranked_books
WHERE rn <= 2;

-- C20 – LAG()

SELECT
    sale_id,
    book_id,
    sale_date,
    quantity,
    LAG(quantity) OVER (
        ORDER BY sale_date
    ) AS previous_quantity
FROM sales
WHERE book_id = 115
ORDER BY sale_date;

-- C21 – Running Total

SELECT
    sale_id,
    book_id,
    sale_date,
    quantity,
    SUM(quantity) OVER (
        ORDER BY sale_date
    ) AS running_total
FROM sales
ORDER BY sale_date;

  -- C22–C24 → CTEs & Synthesis  
  -- C22 – CTE

WITH book_sales AS (
    SELECT
        book_id,
        SUM(quantity) AS total_quantity
    FROM sales
    GROUP BY book_id
)
SELECT
    b.title,
    bs.total_quantity
FROM books b
INNER JOIN book_sales bs
    ON b.book_id = bs.book_id;
    
    -- C23 – Multi-CTE + RANK()

WITH genre_revenue AS (
    SELECT
        b.genre,
        SUM(s.quantity * b.price) AS revenue
    FROM sales s
    INNER JOIN books b
        ON s.book_id = b.book_id
    GROUP BY b.genre
),
ranked_genres AS (
    SELECT
        genre,
        revenue,
        RANK() OVER (
            ORDER BY revenue DESC
        ) AS revenue_rank
    FROM genre_revenue
)
SELECT
    genre,
    revenue,
    revenue_rank
FROM ranked_genres
ORDER BY revenue_rank;

-- C24 – Comprehensive CTE + Window Function Query

WITH book_sales AS (
    SELECT
        b.book_id,
        b.genre,
        b.author_id,
        SUM(s.quantity) AS total_quantity,
        SUM(s.quantity * b.price) AS book_revenue
    FROM books b
    INNER JOIN sales s
        ON b.book_id = s.book_id
    GROUP BY
        b.book_id,
        b.genre,
        b.author_id
),
ranked_books AS (
    SELECT
        book_id,
        genre,
        author_id,
        total_quantity,
        ROW_NUMBER() OVER (
            PARTITION BY genre
            ORDER BY total_quantity DESC
        ) AS book_rank
    FROM book_sales
),
genre_revenue AS (
    SELECT
        genre,
        SUM(book_revenue) AS total_genre_revenue
    FROM book_sales
    GROUP BY genre
)
SELECT
    rb.genre,
    b.title,
    a.name AS author_name,
    rb.total_quantity,
    gr.total_genre_revenue
FROM ranked_books rb
INNER JOIN books b
    ON rb.book_id = b.book_id
INNER JOIN authors a
    ON rb.author_id = a.author_id
INNER JOIN genre_revenue gr
    ON rb.genre = gr.genre
WHERE rb.book_rank = 1
ORDER BY gr.total_genre_revenue DESC;
