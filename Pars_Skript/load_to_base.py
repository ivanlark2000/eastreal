from config import config


def arg_value(lst_arg: list, dct: dict) -> tuple[str, str]:
    lst_column = []
    lst_data = []
    lst_data_out = []
    for arg in lst_arg:
        for key in dct:
            if dct[key] and arg == key:
                lst_column.append(arg)
                lst_data.append(dct[key])
    for i in [str(s) for s in lst_data]:
        if not i.isdigit():
            i = f"'{i}'"
        lst_data_out.append(i)
    return ', '.join(lst_column), ', '.join(str(x) for x in lst_data_out)


def load_to_base(dct) -> None:
    lst_arg = [
        'S_Area',
        'S_City',
        'S_District',
        'S_Street',
        'S_Type_Street',
        'N_Street',
        'S_Qty_Room',
        'N_Qty_Total_Space',
        'N_Qty_Living_Space',
        'N_Qty_Kitchen_Space',
        'N_Price',
        'N_Floor',
        'B_Balcony',
        'B_Loggia',
        'S_Type_Of_Room',
        'S_Ads_Type',
        'N_Ceiling_Height',
        'S_Type_Bathroom',
        'S_Window',
        'S_Kind_Of_Repair',
        'B_Heating',
        'S_Furniture',
        'S_Technics',
        'S_Decorating',
        'S_Method_Of_Sale',
        'S_Type_Of_Transaction',
        'S_Description',
        'S_Type_House',
        'N_Year_Building',
        'N_Floor_In_House',
        'B_Passenger_Elevator',
        'B_Freight_Elevator',
        'S_Yard',
        'S_Parking',
        'S_Name_New_Building',
        'S_Official_Builder',
        'S_Type_of_Participation',
        'D_Deadline_for_Delivery',
        'S_Site_Links',
        'F_Source',
        'S_Name_Seller',
        'S_Type_Of_Seller'
    ]
    atr = arg_value(lst_arg, dct)
    conn = config.make_con()
    cursor = conn.cursor()
    cursor.execute(f"""INSERT INTO BF_Temp_Apartments_Ads ({atr[0]})
           VALUES ({atr[1]})""")
    conn.commit()
    cursor.close()
