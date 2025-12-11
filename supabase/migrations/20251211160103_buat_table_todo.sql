create table todos (
    id serial primary key,
    title text not null,
    is_completed boolean default false,
    created_at timestamp with time zone default now()
)