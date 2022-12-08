INSERT INTO FS_Source (C_Name, C_Const, S_Domen)
VALUES  ('авито', 'avito', 'https://www.domofond.ru/'),
    ('домофонд', 'domfond', 'https://www.avito.ru/');

INSERT INTO FS_Session (S_SourceName)
VALUES ('Trans_Temp_To_Const')