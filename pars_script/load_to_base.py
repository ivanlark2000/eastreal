import sys
import configparser
sys.path.insert(1, '/home/lark/PROJECT/RealEstate/settings')
from config import config


logger = config.make_logger('parsAvito.log')


lst_arg = [
    'site_id',
    'S_City',
    'S_District',
    'S_Street',
    'S_Qty_Room',
    'N_Qty_Total_Space',
    'N_Qty_Living_Space',
    'N_Qty_Kitchen_Space',
    'N_Price',
    'N_Floor',
    'B_Balcony',
    'B_Loggia',
    'S_Type_Room',
    'S_Ads_Type',
    'N_Ceiling_Height',
    'S_Bathroom_Type',
    'S_Window',
    'S_Repair_Type',
    'B_Heating',
    'S_Furniture',
    'S_Technics',   
    'S_decoration',
    'S_Method_Of_Sale',
    'S_Type_Of_Transaction',
    'S_Description',
    'S_Type_House',
    'N_Year_Building',
    'S_Qty_floor',
    'B_Passenger_Elevator',
    'B_Freight_Elevator',
    'S_Yard',
    'S_Parking',
    'S_Name_New_Building',
    'S_Official_Builder',
    'S_Participation_Type',
    'D_Deadline_for_Delivery',
    'S_Site_Links', 
    'F_Source',
    'S_Seller',
    'S_Seller_Type',
]



def get_id_in_base(city_id: int) -> tuple[tuple[str, int]]:
    # функция возвращает список айдишников квартир и цен на текущий момент
    conn = config.make_con()
    try:
        with conn.cursor() as cursor:
            cursor.execute(f"SELECT * FROM get_siteid_price('{city_id}', '1');")
            logger.info('Получили айдишники квартир сайта с БД')
            return tuple([tuple([i[0], i[1], (i[2])]) for i in cursor.fetchall()])
    except Exception as e:
        msg = 'Не удалось получить айдишники кватир сайта с бд' + str(e)
        print(msg)
        logger.critical(msg, exc_info=True)
    finally:
        conn.close()


def arg_value(arg: list, dct: dict) -> tuple[str, str]:
    lst_column = []
    lst_data = []
    lst_data_out = []
    for a in arg:
        for key in dct:
            if dct[key] and a == key:
                lst_column.append(a)
                lst_data.append(dct[key])
    for i in [str(s) for s in lst_data]:
        if not i.isdigit():
            i = f"'{i}'"
        lst_data_out.append(i)
    return ', '.join(lst_column), ', '.join(str(x) for x in lst_data_out)


def load_to_base(dct: dict, count: int) -> None:
    from main import CITY_ID
    conn = config.make_con()
    atr = arg_value(lst_arg, dct)
    try:
        with conn.cursor() as cursor:
            cursor.execute(f"""INSERT INTO BF_Temp_Apartments_Ads ({atr[0]})
                   VALUES ({atr[1]})""")
            msg = f"В базу закачалось {count} квартрира с айдишником {dct['site_id']} c адресом {dct['S_Street']}"
            print(msg)
    except Exception as e:
        msg = f"квартрира с айдишником {dct['site_id']} c адресом {dct['S_Street']} не была закачена"
        logger.critical(msg, exc_info=True)
        print(msg)
        load_miss_number(site_id=dct['site_id'], city_id=CITY_ID)
    finally:
        conn.close()


def load_price_to_base(f_flat: int, n_price: int) -> None:
    conn = config.make_con()
    cursor = conn.cursor()
    sql = f"""
            INSERT INTO mn_ads_price (f_flat, n_price)
            VALUES ({f_flat}, {n_price});
            """
    try:
        cursor.execute(f"""
            INSERT INTO mn_ads_price (f_flat, n_price)
            VALUES ({f_flat}, {n_price});
            """)
        conn.commit()
        print('Ценна загруженна')
    except Exception as e:
        print('Ошибка в загрузке данных по цене')
    finally:
        cursor.close()


def load_miss_number(site_id: str, city_id: int) -> None:
    conn = config.make_con()
    cursor = conn.cursor()
    try:
        cursor.execute(f"""
                    INSERT INTO inf_miss_ads (f_city, site_id, f_source, f_sell_status)
                    VALUES ({city_id}, {int(site_id)}, 1, 1);
                       """)
        conn.commit()
        print(f'Добавили в БД айдишник {site_id} ошибочного объявления')
    except Exception as e:
        print(f'Не удалось добавить айдишник {site_id} ошибочного объявления' + str(e))
    finally:
        cursor.close()


def update_sell_status(city_id: int, siteids:list) -> None:
    conn = config.make_con()
    try:
        with conn.cursor() as cursor:
            cursor.execute(f"SELECT update_sell_status('{city_id}',VARIADIC ARRAY{siteids});")
            conn.commit()
            logger.info('Айдишники проданых квартир успешно переведенны в статус проданны')
    except Exception as e:
        logger.warning('Статусы проданыных квартир не были переведены в историчность', exc_info=True)
    finally:
        conn.close
    

