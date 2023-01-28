from pars_script.settings.config import config

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
    'S_Seller_Type'
]


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
    from pars_script.main import logger
    atr = arg_value(lst_arg, dct)
    try:
        conn = config.make_con()
        cursor = conn.cursor()
        cursor.execute(f"""INSERT INTO BF_Temp_Apartments_Ads ({atr[0]})
               VALUES ({atr[1]})""")
        conn.commit()
        cursor.close()
        msg = f"В базу закачалось {count} квартрира с айдишником {dct['site_id']} c адресом {dct['S_Street']}"
        logger.info(msg)
        print(msg)
    except Exception as e:
        msg = f"квартрира с айдишником {dct['site_id']} c адресом {dct['S_Street']} не была закачена"
        logger.critical(msg, exc_info=True)
        print(msg)