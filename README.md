# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
## ER図

```mermaid
erDiagram
    users ||--o{ reviews : writes
    books ||--o{ reviews : receives

    users {
        bigint id PK
        varchar name "名称"
        varchar username "ユーザー名"
    }

    books {
        bigint id PK
        string author "著者名"
        string isbn "ISBN"
        date published_at "出版日"
        string title "タイトル"
    }

    reviews {
        bigint id PK
        bigint user_id FK
        bigint book_id FK
    }
```