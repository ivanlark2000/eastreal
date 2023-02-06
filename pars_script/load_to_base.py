import sys
import configparser
sys.path.insert(1, '/home/lark/PROJECT/RealEstate/settings')
from config import config


conf = configparser.ConfigParser()
conf.read('sql_request.ini')


logger = config.logger
conn = config.make_con()


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



def get_id_in_base(city_id: int, logger: object) -> tuple[tuple[str, int]]:
    # функция возрашает список айдишников квартир и цен на текуший момент
    cursor = conn.cursor()
    try:
        cursor.execute(conf['SQL']['site_id-price.part_1'] + str(city_id))
        rez = cursor.fetchall()
        logger.info('Получили айдишники квартир сайта с БД')
        return tuple([tuple([i[0], i[1], int(i[2])]) for i in rez])
    except Exception as e:
        msg = 'Не удалось получить айдишники кватир сайта с бд' + str(e)
        print(msg)
        logger.critical(msg, exc_info=True)
    finally:
        cursor.close()

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
    cursor = conn.cursor()
    atr = arg_value(lst_arg, dct)
    try:
        cursor.execute(f"""INSERT INTO BF_Temp_Apartments_Ads ({atr[0]})
               VALUES ({atr[1]})""")
        conn.commit()
        cursor.close()
        msg = f"В базу закачалось {count} квартрира с айдишником {dct['site_id']} c адресом {dct['S_Street']}"
        print(msg)
    except Exception as e:
        msg = f"квартрира с айдишником {dct['site_id']} c адресом {dct['S_Street']} не была закачена"
        logger.critical(msg, exc_info=True)
        print(msg)
    finally:
        cursor.close()

def load_price_to_base(f_flat: int, n_price: int) -> None:
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


def load_miss_number(site_id: str) -> None:
    cursor = conn.cursor()
    try:
        cursor.execute(f"""
                    INSERT INTO inf_miss_ads (f_city, site_id, f_source)
                    VALUES ({CITY_ID}, {site_id}, 1);
                       """)
        print(f'Добавили в БД айдишник {site_id} ошибочного объявления')
    except Exception as e:
        print(f'Не удалось добавить айдишник {site_id} ошибочного объявления')

