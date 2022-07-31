from app.avito_pars import parsAvitoFlat, parsAvitoHouse
from app.load_in_base import load_in_base


def main():
    file = open('../sys/flat.html', 'r')
    html = file.read()
    file.close()
    flat_in_avito = parsAvitoFlat(html)
    house_in_avito = parsAvitoHouse(html)
    load_in_base(
        flat=flat_in_avito,
        house=house_in_avito
    )


if __name__ == "__main__":
    main()
