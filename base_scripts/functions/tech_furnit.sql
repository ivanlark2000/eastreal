--DROP FUNCTION add_technics(f_flat integer, s_items text, vainteger)
create or replace FUNCTION public.add_technics(
	f_flat integer,
	s_items text,
	var integer)
    RETURNS void
AS $BODY$
items = s_items
items = [i.strip() for i in items.split(',')]

if var == 1:
    table_main = 'ES_Furniture'
    fk = 'f_furniture_types'
    table = 'FS_Furniture_Types'

else:
    table_main = 'ES_Technics'
    fk = 'f_technics_type'
    table = 'FS_Technic_Types'


plan = plpy.prepare(f'SELECT {fk} FROM  {table_main} WHERE f_flat = $1', ['int'])
active = plpy.execute(plan, [f_flat])

items_active = [i[fk] for i in active]

response = plpy.execute(f'SELECT link, C_Name FROM {table}')

plan = plpy.prepare(f'INSERT INTO {table} (C_Name) VALUES ($1)', ['text'])
for item in items:
    if item not in [i['c_name'] for i in response]:
        plpy.execute(plan, [item])

lst = []
response = plpy.execute(f'SELECT link, C_Name FROM {table}')
#plpy.notice(response)
for i in response:
	for r in items:
		if r == i['c_name']:
			lst.append(i['link'])

items = lst
plan = plpy.prepare(f'DELETE FROM {table_main} WHERE F_Flat = $1 AND {fk} = $2', ['int', 'int'])
for i in items_active:
    if i not in items:
        plpy.execute(plan, [f_flat, i])

plan = plpy.prepare(f'INSERT INTO {table_main} (f_flat, {fk}) VALUES ($1, $2)', ['int', 'int'])
for i in items:
	if i not in items_active:
		plpy.execute(plan, [f_flat, i])

$BODY$

LANGUAGE 'plpython3u'
