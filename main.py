# coding=utf-8
from def_list import getting_total_html, getting_links, getting_rendom_link, getting_html_flat, getting_url
from def_list import sanding_add_in_base, checking_build, sending_build, checking_flat, clearing_none, adding_price
from class_list import Flats, Buildings


def main(page=1):
    url = next(getting_url())
    clearing_none()
    while True:
        if url is None:
            url = getting_url()
        html = getting_total_html(url)
        list_links = getting_links(html)
        links = getting_rendom_link(list_links)
        for link in next(links):
            print(link)
            html_flat = getting_html_flat(link)
            if html_flat is None:
                continue
            fl = Flats(html_flat)
            build = Buildings(html_flat)
            if checking_flat(id=fl.flat_id) is None:
                sanding_add_in_base(
                    id=fl.flat_id, address=fl.address, price=fl.price, distr=fl.district, number=fl.number_of_rooms,
                    square=fl.square_of_kitchen, space=fl.living_space, floor=fl.floor, fur=fl.furniture,
                    tech=fl.technics, balc=fl.balcony_or_loggia, room=fl.room_type, ceil=fl.ceiling_height,
                    bath=fl.bathroom, win=fl.widow, repair=fl.repair, seil=fl.seilling_method,
                    trans=fl.transaction_type, dec=fl.decorating, total=fl.total_space, pag=page
                )
                page += 1
            else:
                adding_price(id_flat=fl.flat_id, price=fl.price)

            if checking_build(build.address) is None:
                sending_build(
                    new=build.new_building_name, addr=build.address, stract=build.structure, off=build.offical_builder,
                    year=build.year_of_construction, floor=build.floors_in_the_hourse, pas=build.passenger_bodice,
                    serv=build.service_lift, in_=build.in_home, pemo=build.pemolition_planned,
                    type=build.type_of_bilding, yard=build.yard, par=build.participation_type, deadline=build.deadline,
                    parc=build.parking
                )


if __name__ == '__main__':
    main()
