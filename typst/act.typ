#import "ru-numbers.typ": ru-words
#import "@preview/zero:0.3.3": num, set-group
#set-group(size: 3, separator: sym.space.thin, threshold: 4)

#let act = json("act.json")

#let act_sum = act.jobs.map(job => job.at("price")).sum()

= Акт выполненных работ

#datetime.today().display("[day].[month].[year]")

#table(
  columns: 2,
  stroke: none,
  inset: (left: 0pt),
  [*Исполнитель:*], [ИП Голобурдин Алексей Анатольевич],
  [*Заказчик:*],    [#act.customer.at("name")]
)

#table(
  columns: 6,
  [№], [Наименование товара], [Ед. изм.], [Кол-во], [Цена, ₽], [Сумма, ₽],
  ..for (index, job) in act.jobs.enumerate() {(
    [
      #align(center)[#(index + 1)]
    ],[
      #job.at("task")
    ], [#align(center)[шт]], [#align(center)[1]], [
      #align(center)[#num(job.at("price"))]
    ],[
      #align(center)[#num(job.at("price"))]
    ]
  )},
)

Общая стоимость выполненных работ, оказанных услуг в российских рублях: #num(act_sum) (#ru-words(act_sum)). Заказчик не имеет претензий по срокам, качеству и объёму товаров и услуг

#table(
  columns: 2,
  stroke: none,
  inset: (left: 0pt),
  [
    *#act.customer.at("name")*
  ], [
    *ИП Голобурдин Алексей Анатольевич*
  ], text(
  )[
    ИНН: #act.customer.at("INN")\
    ОГРН: #act.customer.at("OGRN")\
    Юридический адрес: #act.customer.at("address")\
    Банк: #act.customer.at("bank").at("name")\
    БИК: #act.customer.at("bank").at("BIC")\
    Расчетный счет: #act.customer.at("bank").at("current_account")\
    Корр. счет: #act.customer.at("bank").at("corporate_account")\
  ],[
    ИНН: 482423943474\
    ОГРНИП: 313482405700058\
    Р/с: 40802810602230000885\
    Банк: АО "АЛЬФА-БАНК"\
    БИК: 044525593\
    Корр. счет: 30101810200000000593
  ],[
    \
    #text("________________/") #act.customer.at("signatory") /
  ], [
    \
    #text("________________/") Голобурдин А.А. /
  ]
)
