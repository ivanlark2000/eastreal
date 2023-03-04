ALTER TABLE inf_sys ADD COLUMN g_sess_create uuid;
COMMENT ON COLUMN inf_sys.g_sess_create IS 'сессия которая добавила запись';

ALTER TABLE bf_temp_apartments_ads ADD COLUMN g_sess uuid;
COMMENT ON COLUMN bf_temp_apartments_ads.g_sess IS 'сессия которая добавила запись';
ALTER TABLE inf_sys ADD COLUMN g_sess_modif uuid;
COMMENT ON COLUMN inf_sys.g_sess_modif IS 'сессия которая изменила  запись';
ALTER TABLE inf_miss_ads ADD COLUMN g_sess_modif uuid;
ALTER TABLE inf_miss_ads ADD COLUMN g_sess_create uuid;
COMMENT ON COLUMN inf_miss_ads.g_sess_modif IS 'сессия которая изменила  запись';
COMMENT ON COLUMN inf_miss_ads.g_sess_create IS 'сессия которая создала  запись';

