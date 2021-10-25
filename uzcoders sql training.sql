#Buyurtma "ID"sini, hisob raqami "ID"sini va barcha buyurtmalar uchun dollarning umumiy miqdorini ko‘rsatadigan so‘rov yozing, avval hisob raqami (o‘sish tartibida), so‘ngra dollarning umumiy miqdori (kamayish tartibida) bo‘yicha tartiblangan.

select id, account_id, total_amt_usd
from orders
order by account_id, total_amt_usd desc

#Takroran buyurtma "ID"sini, hisob raqami "ID"sini va barcha buyurtmalar uchun dollarning umumiy miqdorini ko‘rsatadigan so‘rov yozing, lekin bu safar avval dollarning umumiy miqdori (kamayish tartibida), so‘ngra hisob raqami (o‘sish tartibida) bo‘yicha tartiblang.

select id, account_id, total_amt_usd
from orders
order by total_amt_usd desc, account_id

#"gloss_amt_usd"ning 1000 dollardan katta yoki teng qiymatiga ega bo‘lgan orders jadvalining birinchi 5 ta qatorini va barcha ustunlarini torting.

select *
from orders
where gloss_amt_usd >= 1000
limit 5

#"total_amt_usd" qiymati 500 dan kam bo‘lgan *orders jadvalining birinchi 10 qatorini va barcha ustunlarini torting.

select *
from orders
where total_amt_usd < 500
limit 10

#"Exxon Mobil" kompaniyasi uchun accounts jadvalida "name", "website" va asosiy aloqalarni ("primary_poc")ni qo‘shish uchun hisoblar jadvalini filtrlang.

select name, website, primary_poc
from accounts
where name = 'Exxon Mobil'

#Har bir buyurtma uchun standart qog‘ozning narxini topish uchun "standart_amt_usd"ni "standart_qty"ga ajratadigan ustun yarating. Natijalarni dastlabki 10 ta buyurtma bilan cheklang hamda "id" va "account_id" maydonlarini kiriting.

select id, account_id, standard_amt_usd/standard_qty as standard_price
from orders
limit 10

#Har bir buyurtma uchun poster qog‘ozidan keladigan daromadning foizini topadigan so‘rov yozing. Faqat "_usd" bilan tugaydigan ustunlardan foydalanishingiz kerak. (Buni "total" ustunidan foydalanmasdan bajarishga harakat qiling.) "Id" va "account_id" maydonlarini ham ko‘rsating.

select id, account_id, (standard_amt_usd + gloss_amt_usd + poster_amt_usd) / poster_amt_usd * 100 as gloss_prct
from orders;

SELECT id, account_id,
       poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd)*100 AS post_per
FROM orders
LIMIT 10;

#Nomlari "C" harfi bilan boshlanadigan barcha kompaniyalar.

select *
from accounts
where name like 'C%';

#Nomida "one" so‘zini o‘z ichiga olgan barcha kompaniyalar.

select *
from accounts
where name like '%one%';

#Nomi "s" harfi bilan tugaydigan barcha kompaniyalar.

select *
from accounts
where name like '%s';

#"Walmart", "Target" va "Nordstrom" uchun hisobning name, primary_poc va sales_rep_id hossalarini topish uchun accounts jadvalidan foydalaning.

select name, primary_poc, sales_rep_id
from accounts
where name in ('Walmart', 'Target', 'Nordstrom')

#"Organic" yoki "adwords" kanali orqali murojaat qilgan shaxslar to‘g‘risidagi barcha ma‘lumotlarni topish uchun web_events jadvalidan foydalaning.

select *
from web_events
where channel in ('%Organic%', '%adwords%')

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords');

#Walmart, Target va Nordstrom dan tashqari barcha do‘konlarda hisob nomi, asosiy manzil va savdo vakolatini topish uchun accounts jadvalidan foydalaning.

select name, primary_poc, sales_rep_id
from accounts
where name not like ('Walmart', 'Target', 'Nordstorm')

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');

#Nomi 'C' bilan boshlanmagan barcha kompaniyalar.

select name, primary_poc, sales_rep_id
from accounts
where name not like ('C%')

#Nomlarida 'one' satri bo‘lmagan barcha kompaniyalar.

select name, primary_poc, sales_rep_id
from accounts
where name not like ('%one%')

#Nomi 's' bilan tugamaydigan barcha kompaniyalar.

select name, primary_poc, sales_rep_id
from accounts
where name not like ('%s')

#Barcha buyurtmalarni natijasini qaytaradigan so‘rov yozing, bunda "standart_qty" 1000 dan ziyod, "poster_qty" 0 ga va "gloss_qty" 0 ga teng bo‘lsin.

select *
from orders
where standard_qty > 1000 and gloss_qty = 0 and poster_qty = 0

#accounts jadvalini ishlatgan holda, "C" harfi bilan boshlanmagan va "s" harfi bilan tugaydigan barcha kompaniyalarni nomlarini qidirib toping.

select *
from accounts
where name not like ('C%') and name like ('%s')

#SQLda "BETWEEN" operatoridan foydalanganingizda, natijalar oxirgi nuqta qiymatlarini o‘z ichiga oladimi yoki yo‘q? Ushbu muhim savolga javobni topish uchun buyurtma sanasini va "gloss_qty" ma‘lumotlarini ko‘rsatadigan so‘rov yozing. Bunda "gloss_qty" qiymati 24 va 29 oralig‘ida bo‘lsin. So‘ngra "BETWEEN" operatori boshlang‘ich va tugash qiymatlarini o‘z ichiga olgan yoki olmaganligini bilish uchun o‘zingizning natijangiz bilan solishtiring.

select occurred_at, gloss_qty
from orders
where gloss_qty between 24 and 29

#web_events jadvalidan foydalanib, "organic" yoki "adwords" kanallari orqali bog‘langan va hisob raqamini 2016-yilda istalgan vaqtda ochgan shaxslar to‘g‘risidagi barcha ma’lumotlarni toping. Natijalar eng yangilaridan to eng eskisiga qarab ko‘rsatilsin.

select *
from web_events
where channel in ('organic', 'adwords')
order by occurred_at

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY occurred_at DESC;

#"gloss_qty" yoki "poster_qty" 4000 dan katta bo‘lgan orderslar "id"larining ro‘yxatini toping. Olingan jadvalga faqat "id" maydonini qo‘shing.

select id
from orders
where gloss_qty > 4000 or poster_qty >4000

#"standart_qty" nolga teng bo‘lsa, yoki "gloss_qty" hamda "poster_qty" 1000 dan yuqori bo‘lgan taqdirda, orders natijasini qaytaradigan so‘rov yozing.

select id
from orders
where standard_qty = 0 or gloss_qty > 1000 and poster_qty > 1000

SELECT *
FROM orders
WHERE standard_qty = 0 AND (gloss_qty > 1000 OR poster_qty > 1000);

#"C" yoki "W" harflari bilan boshlanadigan barcha tashkilot nomlarini toping va asosiy kontakt 'ana' yoki 'Ana' so‘zini o‘z ichiga olsin, ammo unda 'eana' mavjud bo‘lmasin.

  select name
  from accounts
  where name like ('C%') or like('W%')
  and
  where primary_poc in ('ana') or in ('Ana') and not in ('eana')

  SELECT *
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%')
              AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%')
              AND primary_poc NOT LIKE '%eana%');

#orders jadvalida eng oxirgi 10 ta buyurtmalarni natijasini qaytaradigan so‘rov yozing. id, occurred_at, va total_amt_usd kalit so‘zlarini kiriting.

select id, occurred_at, total_amt_usd
from orders
order by id desc
limit 10

#total_amt_usd shartlariga binoan eng yuqori 5 ta orders natija sifatida qaytarish uchun so‘rov yozing. id, account_id, va total_amt_usd kalit so‘zlarni ichiga olsin.

select id, account_id, total_amt_usd
from orders
order by total_amt_usd desc
limit 5

#total_amt_usd shartlariga ko‘ra eng kam 20 ta orders natija sifatida qaytarish uchun so‘rov yozing. id, account_id, va total_amt_usd kalit so‘zlarni ichiga olsin.

select id, account_id, total_amt_usd
from orders
order by total_amt_usd
limit 20

#orders jadvalidagi 10 ta oldingi buyurtmalarni natija sifatida qaytarish uchun so‘rov yozing. id, occurred_at, and total_amt_usd kalit so‘zlarini ichiga olsin.

SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at
LIMIT 10;
#total_amt_usd shartlariga binoan eng yuqori 5 ta buyurtmalarni natija sifatida qaytarish uchun so‘rov yozing. id, account_id, va total_amt_usd kalit so‘zlarni ichiga olsin.

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;
#total_amt_usd shartlariga ko‘ra eng kam 20 ta buyurtmalarni natija sifatida qaytarish uchun so‘rov yozing. id, account_id, va total_amt_usd kalit so‘zlari ichiga olsin.
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd
LIMIT 20;

#Buyurtma "ID"sini, hisob raqami "ID"sini va barcha buyurtmalar uchun dollarning umumiy miqdorini ko‘rsatadigan so‘rov yozing, avval hisob raqami (o‘sish tartibida), so‘ngra dollarning umumiy miqdori (kamayish tartibida) bo‘yicha tartiblangan.

select id, account_id, total_amt_usd
from orders
order by account_id, total_amt_usd desc

#accounts jadvalidagi va orders jadvalidagi barcha ma’lumotlarni olishga harakat qiing.

SELECT orders.*, accounts.*
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

#standard_qty, gloss_qty, va poster_qty ni orders jadvalidan hamda website va primary_poc ni accounts jadvalidan olishga harakat qiling.

SELECT orders.standard_qty, orders.gloss_qty, orders.poster_qty, accounts.website, accounts.primary_poc
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

#"Walmart" ning "account name" (hisob nomi) bilan bog‘liq bo‘lgan barcha web_events uchun jadval taqdim eting. Unda uchta ustun bo‘lishi kerak. Har bir tadbir uchun primary_poc, tadbir vaqti va channel (kanal)ni qo‘shganingizga ishonch hosil qiling. Bundan tashqari, faqat "Walmart" tadbirlari tanlanganligiga ishonch hosil qilish uchun to‘rtinchi ustunni qo‘shishingiz mumkin.

SELECT accounts.name, accounts.primary_poc, web_events.occurred_at, web_events.channel
from accounts
join web_events
on accounts.id = web_events.account_id
where accounts.name = 'Walmart'

SELECT a.primary_poc, w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
WHERE a.name = 'Walmart';

#Har bir sales_rep uchun region va accounts (ularning hisob qaydnomalari) bilan ta’minlangan jadvalni taqdim eting. Sizning oxirgi jadvalingiz 3 ta ustunni o‘z ichiga olishi kerak.: hudud nomi, savdo vakili nomi, va hisob nomi. Hisoblarni nomiga qarab alifbo tartibida tartiblang (A-Z).

select region.name, sales_reps.name, accounts.name
from region
join sales_reps
on region.id = sales_reps.region_id
join accounts
on sales_reps.id = accounts.sales_rep_id
order by accounts.name
limit 3

SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY a.name;

#Har bir buyurtma uchun har bir mintaqaga nom ni, shuningdek, buyurtma uchun to‘lagan hisob nomini va birligining narxini (total_amt_usd/total) ko‘rsating. Yakuniy jadvalda 3 ta ustun bo‘lishi kerak: region name (mintaqa nomi), accaunt name (hisob nomi) va unit price (narx birligi). Bir nechta hisoblarda total (jami) uchun 0 bor, shuning uchun nolga bo‘linmasligimni ta’minlash uchun uni ikkiga bo‘ldim (total + 0.01).

SELECT r.name region, a.name account,
       o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id;

#Har bir sales_rep uchun region va ularning tegishli accountslari bilan ta’minlangan jadvalni taqdim eting. Bu safar faqat "Midwest" mintaqasi uchun. Sizning yakuniy jadvalingizda uchta ustun bo‘lishi kerak: "region name", "sales rep name" va "account name". Hisoblarni nomiga qarab alifbo tartibida tartiblang (A-Z).

select r.name region, s.name rep, a.name account
from sales_reps s
join region r
on s.region_id = r.id
join accounts a
on s.id = a.sales_rep_id
where r.name = 'Midwest'
order by a.name



#Har bir sales_rep uchun region va ularning tegishli accountslari bilan ta’minlangan jadvalni taqdim eting. Bu safar faqat "sales rep" (savdo vakili) ismi(first name)'S' dan boshlanadigan va 'Midwest' mintaqasida joylashgan hisoblar uchun. Sizning yakuniy jadvalingizda uchta ustun bo‘lishi kerak: "region name", "sales rep name" va "account name". Hisoblarni nomiga qarab alifbo tartibida tartiblang (A-Z).

select r.name region, s.name rep, a.name account
from sales_reps s
join region r
on s.region_id = r.id
join accounts a
on a.sales_rep_id = s.id
where s.name like 'S%' and r.name like 'Midwest'
order by a.name


#Har bir sales_rep uchun region va ularning tegishli accountslari bilan ta’minlangan jadvalni taqdim eting. Bu safar faqat savdo vakili familiyasi(last name) 'K' dan boshlanadigan va "Midwest" mintaqasida joylashgan hisoblar uchun. Sizning yakuniy jadvalingizda uchta ustun bo‘lishi kerak: "region name", "sales rep name" va "account name". Hisoblarni nomiga qarab alifbo tartibida tartiblang (A-Z).

select r.name region, s.name rep, a.name account
from sales_reps s
join region r
on s.region_id = r.id
join accounts a
on a.sales_rep_id = s.id
where s.name like '% K%' and r.name like 'Midwest'
order by a.name



#Har bir order (buyurtma) uchun har bir "region name" (mintaqa nomi)ni, shuningdek, "account name" (hisobning nomi) va buyurtma uchun ular to‘lagan unit price (birlik narx)ni ("total_amt_usd / total") ko‘rsating. Biroq, siz natijalarni faqat standard order quantity (standart buyurtma miqdori) '100'dan oshgan taqdirdagina berishingiz kerak. Sizning yakuniy jadvalingizda uchta ustun bo‘lishi kerak: region name, account name, va unit price. Nol bilan bo‘linish xatosini oldini olish uchun bu yerda maxrajga .01 qo‘shilishi "total_amt_usd / (jami + 0.01)" foydalidir.

select r.name region, a.name account, o.total_amt_usd/(o.total+0.01) unitprice
from orders o
join accounts a
on o.account_id = a.id
join sales_reps s
on a.sales_rep_id = s.id
join region r
on s.region_id = r.id
where o.standard_qty > 100




#