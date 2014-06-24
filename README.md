Run as `bundle exec ruby app.rb -sv`

Create table with:
`create table users (
  account_id varchar(255) not null,
  group_id varchar(255) not null,
  keystone_user varchar(255) not null,
  keystone_pass varchar(255) not null,
  unique key uid_gid_uniq (account_id, group_id),
  unique key name_uniq (keystone_user)
);`

Ask for token:
`curl -H "Content-Type: application/json" -d '{"group_id": "100", "account_id": "1001"}' http://localhost:9000/api/keystone/token`

