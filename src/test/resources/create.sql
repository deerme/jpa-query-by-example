DROP ALL OBJECTS;

CREATE TABLE ADDRESS (
    id                          int not null IDENTITY,
    street_name                 varchar(100),
    city                        varchar(100) not null,
    version                     int default 0,

    primary key (id)
);

CREATE TABLE ACCOUNT (
    id                       char(32) not null,
    login                    varchar(100) not null,
    password                 varchar(100) not null,
    email                    varchar(100) not null,
    is_enabled               bool,
    civility                 char(2),
    first_name               varchar(100),
    last_name                varchar(100),
    birth_date               timestamp,
    description              varchar(255),
    address_id               int,
    creation_date            timestamp,
    creation_author          varchar(200),
    last_modification_date   timestamp,
    last_modification_author varchar(200),
    version                  int default 0, 

    constraint account_unique_1 unique (login),
    constraint account_unique_2 unique (email),
    constraint account_fk_1 foreign key (address_id) references ADDRESS,
    primary key (id)
);

CREATE TABLE ROLE (
    id        int          generated by default as identity,
    role_name varchar(100) not null,

    constraint role_unique_1 unique (role_name),
    primary key (id)
);

CREATE TABLE ACCOUNT_ROLE (
    account_id  char(32) not null,
    role_id     int not null,

    constraint account_role_fk_1 foreign key (account_id) references ACCOUNT,
    constraint account_role_fk_2 foreign key (role_id) references ROLE,
    primary key (account_id, role_id)
);


INSERT INTO ADDRESS (street_name, city) values('Avenue des champs Elysées', 'Paris');
INSERT INTO ADDRESS (street_name, city) values('Park avenue', 'New-York');
INSERT INTO ADDRESS (street_name, city) values('California Street', 'San Francisco');
INSERT INTO ADDRESS (street_name, city) values('742 Evergreen Terrasse', 'Springfield');

INSERT INTO ACCOUNT (id, login, password, email, is_enabled, address_id) VALUES ('0000000000000000000000000000001', 'admin', 'admin', 'admin@example.com', true, 1);
INSERT INTO ACCOUNT (id, login, password, email, is_enabled, address_id) VALUES ('0000000000000000000000000000002', 'user',  'user',  'user@example.com', true, 2);
INSERT INTO ACCOUNT (id, login, password, email, is_enabled, address_id) VALUES ('0000000000000000000000000000003', 'demo',  'demo',  'demo@example.com', true, 3);
INSERT INTO ACCOUNT (id, login, password, email, is_enabled, address_id) VALUES ('000000000000000000000000000004', 'disabled',  'disabled',  'disabled@example.com', false, 3);
INSERT INTO ACCOUNT (id, login, password, email, civility, address_id, birth_date) VALUES ('000000000000000000000000000005', 'homer',  'homer',  'homer@example.com', 'MR', 4, PARSEDATETIME('01/01/1972','dd/mm/yyyy'));
INSERT INTO ACCOUNT (id, login, password, email, civility, address_id, birth_date) VALUES ('000000000000000000000000000006', 'maggy',  'maggy',  'maggy@example.com', 'MS', 4, PARSEDATETIME('01/01/1982','dd/mm/yyyy'));

INSERT INTO ROLE (role_name) VALUES ('ROLE_ADMIN');
INSERT INTO ROLE (role_name) VALUES ('ROLE_USER');
INSERT INTO ROLE (role_name) VALUES ('ROLE_UNASSIGNED');

INSERT INTO ACCOUNT_ROLE (account_id, role_id) VALUES ('0000000000000000000000000000001', 1);
INSERT INTO ACCOUNT_ROLE (account_id, role_id) VALUES ('0000000000000000000000000000001', 2);
INSERT INTO ACCOUNT_ROLE (account_id, role_id) VALUES ('0000000000000000000000000000002', 2);
INSERT INTO ACCOUNT_ROLE (account_id, role_id) VALUES ('0000000000000000000000000000003', 2);
