create TABLE Authors (
    author_id SERIAL PRIMARY KEY,
    author_name VARCHAR(250) NOT NULL
);

create TABLE Books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(250) NOT NULL,
    published_year INT NOT NULL,
    author_id INT,
    FOREIGN KEY (author_id ) REFERENCES Authors(author_id)
);
ALTER TABLE books ADD COLUMN genre VARCHAR(100);
ALTER TABLE Books ADD CONSTRAINT published_year CHECK (published_year <= 2025)

ALTER TABLE Books DROP COLUMN author_id;

create TABLE Book_Authors (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id ) REFERENCES Books(book_id),
    FOREIGN KEY (author_id ) REFERENCES Authors(author_id)
);
create TABLE  Temp_Table (
    temp_id INT
);

DROP TABLE Temp_Table
