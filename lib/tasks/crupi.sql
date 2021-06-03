create table data_games (
  id serial primary key,
  date date not null,
  home text not null,
  guest text not null,
  score_home int not null,
  score_guest int not null,
  num int not null
);
