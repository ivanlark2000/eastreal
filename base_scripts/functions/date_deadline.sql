-- FUNCTION: public.date_deadline(integer, text)
-- Функция для вставки отрезка времени по дате сдачи дома
-- DROP FUNCTION IF EXISTS public.date_deadline(integer, text);

CREATE OR REPLACE FUNCTION public.date_deadline(
	f_house integer,
	d_date text)
    RETURNS integer
    LANGUAGE 'plpython3u'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

plan =  plpy.prepare('SELECT * FROM MN_Period_Deadline WHERE F_House = $1 ORDER BY D_Date_Create', ['int'])
response = plpy.execute(plan, [f_house])

date = d_date
if not date:
	return

date = date.strip().split(' ')
if len(date) == 1:
    return

year = int(date[2])

d_date_start = None
d_date_end = None

match int(date[0]):
    case 1:
        d_date_start = f'{year}-01-01 00:00:00'
        d_date_end =   f'{year}-03-31 00:00:00'
    case 2:
        d_date_start = f'{year}-03-01 00:00:00'
        d_date_end = f'{year}-06-30 00:00:00'
    case 3:
        d_date_start = f'{year}-06-01 00:00:00'
        d_date_end = f'{year}-09-30 00:00:00'
    case 4:
        d_date_start = f'{year}-09-01 00:00:00'
        d_date_end = f'{year + 1}-01-01 00:00:00'

if response:
	if str(response[0]['d_date_start']) == d_date_start or  str(response[0]['d_date_end']) == d_date_end:
		return

plan = plpy.prepare('INSERT INTO MN_Period_Deadline (F_House, D_Date_Start, D_Date_End) VALUES ($1, $2, $3)', ['int', 'timestamp', 'timestamp'])
plpy.execute(plan, [f_house, d_date_start, d_date_end])
return

$BODY$;

ALTER FUNCTION public.date_deadline(integer, text)
    OWNER TO ivan;