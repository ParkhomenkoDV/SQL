--SQL tutorial

/*
Теорема CAP:
C = Целостность/консистенстность = Каждая нода (узел) видит одни и те же данные в одинаковом состоянии в заданную единицу времени
A = Доступность = система продолжает работать, ладе если какие-то ноды в кластере не справляются или не доступны
P = Устойчивость к раздедлению = рпасщепление распределенной системы на несколько изолдированных секций не приводит к некорректной работе
*/



--восстановление БД



--работа с базой данных (БД)


--однострочный комментарий

/*
многострочный 
комментарий
*/


/*
Синтаксический порядок инструкции
1) select - вывод чего-то в результат
2) from - изначальная таблица с которой нужно работать 
3) join - присоединение других таблиц
4) on - условие по которому соединяете таблицы
5) where - фильтрация данных
6) group by - группировка данных 
7) having - условие к сгруппированным данным
8) order by - сортировка данных
9) offset/limit

Логический порядок инструкции
1) from
2) on
3) join
4) where
5) group by
6) having
7) select -- алиасы
8) order by
9) offset/limit
*/

select * --* = все
from actor --из таблицы actor

select * --выбери все
from "dvd-rental".actor --из схемы dvd-rental таблицы actor

--двойные кавычки " необходимы в том случае, когда в названии есть неоднозначный символ (минус, например)

select *
from address

select *
from hr.address  --из схемы hr таблицы actor


--установка пути поиска схемы к hr
SET search_path TO hr;  
SET search_path TO "dvd-rental"; 

select *
from address  --теперь работает без указания схемы явно

select * 
from actor  --теперь работает без указания схемы явно


/*
Отличие ' ' от " "

' ' - значение
" " - названия сущностей (Зарезервированные слова)
*/

select name
from language 

select "name"
from "language" 

select 'name'  --name - это не значение, это колонка (сущность)!
from language

select name  
from 'language'  --language - это не значение, это табдица (сущность)!

select "select"  --такой сущности нет
from "from"




--ЗАДАНИЕ №1
--Выведите уникальные названия городов из таблицы городов.


--ЗАДАНИЕ №2
--Доработайте запрос из предыдущего задания, чтобы запрос выводил только те города,
--названия которых начинаются на “L” и заканчиваются на “a”, и названия не содержат пробелов.


--ЗАДАНИЕ №3
--Получите из таблицы платежей за прокат фильмов информацию по платежам, которые выполнялись 
--в промежуток с 17 июня 2005 года по 19 июня 2005 года включительно, 
--и стоимость которых превышает 1.00.
--Платежи нужно отсортировать по дате платежа.


--ЗАДАНИЕ №4
-- Выведите информацию о 10-ти последних платежах за прокат фильмов.
 

--ЗАДАНИЕ №5
--Выведите следующую информацию по покупателям:
--  1. Фамилия и имя (в одной колонке через пробел)
--  2. Электронная почта
--  3. Длину значения поля email
--  4. Дату последнего обновления записи о покупателе (без времени)
--Каждой колонке задайте наименование на русском языке.


--ЗАДАНИЕ №6
--Выведите одним запросом только активных покупателей, имена которых KELLY или WILLIE.
--Все буквы в фамилии и имени из верхнего регистра должны быть переведены в нижний регистр.


--======== ДОПОЛНИТЕЛЬНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Выведите информацию о фильмах, у которых рейтинг “R” и стоимость аренды указана от 
--0.00 до 3.00 включительно, а также фильмы c рейтингом “PG-13” и стоимостью аренды больше или равной 4.00.


--ЗАДАНИЕ №2
--Получите информацию о трёх фильмах с самым длинным описанием фильма.


--ЗАДАНИЕ №3
-- Выведите Email каждого покупателя, разделив значение Email на 2 отдельных колонки:
--в первой колонке должно быть значение, указанное до @, 
--во второй колонке должно быть значение, указанное после @.


--ЗАДАНИЕ №4
--Доработайте запрос из предыдущего задания, скорректируйте значения в новых колонках: 
--первая буква строки должна быть заглавной, остальные строчными.


--p2-46


pg_typeof(), приведение типов

select pg_typeof(100)

select pg_typeof(100.)

select pg_typeof('100')

int | text

select '100' + 100

select pg_typeof('100'::int::text::date)

select pg_typeof(cast('100' as int))

1. Получите атрибуты id фильма, название, описание, год релиза из таблицы фильмы.
Переименуйте поля так, чтобы все они начинались со слова Film (FilmTitle вместо title и тп)
- используйте ER - диаграмму, чтобы найти подходящую таблицу
- as - для задания синонимов 

select film_id, title, description, release_year
from film 

select film_id FilmFilm_id, title FilmTitle, description FilmDescription, release_year FilmRelease_year
from film 

select film_id as FilmFilm_id, title as FilmTitle, description as FilmDescription, release_year as FilmRelease_year
from film 

select film_id "FilmFilm_id", title "FilmTitle", description "FilmDescription", release_year "Год выпуска фильма"
from film 

create table "JKHSVBDFLISLI"

select title "названия наших фильмов с очень длинным названием столбца"
from film 

select *
from (
	select c.first_name f1, c2.first_name f2
	from customer c, customer c2) t
where t.f1 = 'MARY'

select *
from (
	select c.first_name as f1, c2.first_name as f2
	from customer as c, customer as c2) as t
where t.f1 = 'MARY'

select *
from (select 100 x) t

2. В одной из таблиц есть два атрибута:
rental_duration - длина периода аренды в днях  
rental_rate - стоимость аренды фильма на этот промежуток времени. 
Для каждого фильма из данной таблицы получите стоимость его аренды в день,
задайте вычисленному столбцу псевдоним cost_per_day
- используйте ER - диаграмму, чтобы найти подходящую таблицу
- стоимость аренды в день - отношение rental_rate к rental_duration
- as - для задания синонимов 

integer
numeric (10,2) 99999999.99
float

select title, rental_rate / rental_duration
from film 

select title, rental_rate / rental_duration cost_per_day
from film 

select title, rental_rate / rental_duration cost_per_day,
	rental_rate + rental_duration,
	rental_rate * rental_duration, 
	rental_rate - rental_duration, 
	power(rental_rate, rental_duration)
from film 

2*
- арифметические действия
- оператор round

select title, round(rental_rate / rental_duration, 2) cost_per_day
from film 

round(numeric, int)
round(float)

select round(100000/6546, 3)

select x,
	round(x::numeric) as x_num,
	round(x::float) as x_fl
from generate_series(-0.5, 9.5, 1) x

2.5 + 2.5 = 2.49999 = 2.50001

3.1 Отсортировать список фильмов по убыванию стоимости за день аренды (п.2)
- используйте order by (по умолчанию сортирует по возрастанию)
- desc - сортировка по убыванию

select title, round(rental_rate / rental_duration, 2) cost_per_day
from film
order by round(rental_rate / rental_duration, 2) desc 

select title, round(rental_rate / rental_duration, 2) cost_per_day
from film
order by cost_per_day desc 

select title, round(rental_rate / rental_duration, 2) cost_per_day
from film
order by 2 desc 

select title, round(rental_rate / rental_duration, 2) cost_per_day
from film
order by 2 --asc 

select title, round(rental_rate / rental_duration, 2) cost_per_day
from film
order by 2 desc 

select title, round(rental_rate / rental_duration, 2) cost_per_day
from film
order by 2 desc, title

3.1* Отсортируйте таблицу платежей по возрастанию суммы платежа (amount)
- используйте ER - диаграмму, чтобы найти подходящую таблицу
- используйте order by 
- asc - сортировка по возрастанию 

select *
from payment 
order by amount

3.2 Вывести топ-10 самых дорогих фильмов по стоимости за день аренды
- используйте limit

топ - 3
1 - 1000
2, 3 - 999
4-20 - 998

1-20
1-3

select title, round(rental_rate / rental_duration, 2) cost_per_day
from film
order by 2 desc
limit 10

select title, round(rental_rate / rental_duration, 2) cost_per_day
from film
order by 2 desc
fetch first 10 rows only

3.2.1 Вывести топ-1 самых дорогих фильмов по стоимости за день аренды, то есть вывести все 62 фильма
--начиная с 13 версии

select title, round(rental_rate / rental_duration, 2) cost_per_day
from film
order by 2 desc
fetch first 63 rows with ties

select version()

3.3 Вывести топ-10 самых дорогих фильмов по стоимости аренды за день, начиная с 58-ой позиции
- воспользуйтесь Limit и offset

select title, round(rental_rate / rental_duration, 2) cost_per_day
from film
order by 2 desc
offset 57
limit 10

3.3* Вывести топ-15 самых низких платежей, начиная с позиции 14000
- воспользуйтесь Limit и offset

select *
from payment
order by amount
offset 13999
limit 15

4. Вывести все уникальные годы выпуска фильмов
- воспользуйтесь distinct

select distinct release_year
from film 

explain analyze --122
select distinct release_year, film_id
from film 
order by 2

explain analyze --93.46
select film_id, release_year
from film 
order by 1

4* Вывести уникальные имена покупателей
- используйте ER - диаграмму, чтобы найти подходящую таблицу
- воспользуйтесь distinct

select first_name --599
from customer 

select distinct first_name --591
from customer 

4.1 нужно получить последний платеж каждого пользователя

select distinct on (customer_id) *  --599
from payment 
order by customer_id, payment_date desc

select distinct on (customer_id, amount) *  --599
from payment 
order by customer_id, amount, payment_date asc

select distinct customer_id --599
from payment 

select distinct *
from payment 
order by customer_id, payment_date desc


5.1. Вывести весь список фильмов, имеющих рейтинг 'PG-13', в виде: "название - год выпуска"
- используйте ER - диаграмму, чтобы найти подходящую таблицу
- "||" - оператор конкатенации, отличие от concat
- where - конструкция фильтрации
- "=" - оператор сравнения

text 
varchar (N) 0 до N
char(N) N строго char(10) 'aaaaa' -> 'aaaaa     '

select title || ' - ' || release_year, rating
from film 
where rating = 'PG-13'

select concat(title, ' - ', release_year), rating
from film 
where rating = 'PG-13'

select concat_ws(' ', last_name, first_name, middle_name)
from person 

select 'Hello' || null

select concat('Hello', null)

5.2 Вывести весь список фильмов, имеющих рейтинг, начинающийся на 'PG'
- cast(название столбца as тип) - преобразование
- like - поиск по шаблону
- ilike - регистронезависимый поиск
- lower
- upper
- length

--запрос ложный
select concat(title, ' - ', release_year), rating
from film 
where rating like 'PG%'

select pg_typeof(rating)
from film 

ОШИБКА: оператор не существует: mpaa_rating ~~ unknown

% - любое количество символов 
_ - строго один символ

select concat(title, ' - ', release_year), rating
from film 
where rating::text like 'PG%'

select concat(title, ' - ', release_year), rating
from film 
where rating::text like '%13'

select concat(title, ' - ', release_year), rating
from film 
where rating::text like '%-%'

select concat(title, ' - ', release_year), rating
from film 
where not rating::text like '%-%'

select concat(title, ' - ', release_year), rating
from film 
where rating::text not like '%-%'

select concat(title, ' - ', release_year), rating
from film 
where rating::text like 'PG___'

select concat(title, ' - ', release_year), rating
from film 
where rating::text like 'PG%' and char_length(rating::text) = 5

select concat(title, ' - ', release_year), rating
from film 
where rating::text ilike 'pg%'

select concat(title, ' - ', release_year), rating
from film 
where upper(rating::text) like 'PG%'

select concat(title, ' - ', release_year), rating
from film 
where lower(rating::text) like 'pg%'

select title, release_year, rating
from film 
where title like '%\%%'
order by 1

select title, release_year, rating
from film 
where title like '%#%%' escape '#'
order by 1

select ''''

select character_length('привет мир') --10

select char_length('привет мир') --10

select length('привет мир') --10

select octet_length('привет мир') --19

select substring('привет мир', 3 , 3)

select substring('привет мир', 3)

select substring('привет мир' from 3 for 3)

select substring('привет мир' from 3)

select left ('привет мир', 3)

select left ('привет мир', -3)

select right ('привет мир', 3)

select right ('привет мир', -3)

select strpos('привет мир', 'мир')

select concat_ws(' ', last_name, first_name, middle_name),
	overlay(concat_ws(' ', last_name, first_name, middle_name) placing 'Петр' from 
		strpos(concat_ws(' ', last_name, first_name, middle_name), 'Даниил') for char_length('Даниил'))
from person 
where first_name = 'Даниил'

select initcap(upper(concat_ws(' ', last_name, first_name, middle_name)))
from person 

select initcap('sdfsd.sdfsdf sdfsdg!dfgdfg&sdfsdf')

Sdfsd.Sdfsdf Sdfsdg!Dfgdfg&Sdfsdf

select split_part(concat_ws(' ', last_name, first_name, middle_name), ' ', 1),
	split_part(concat_ws(' ', last_name, first_name, middle_name), ' ', 2),
	split_part(concat_ws(' ', last_name, first_name, middle_name), ' ', 3)
from person 

1 Литвинова
2 Амелия
3 Егоровна

select substring('привет мир', strpos('привет мир', ' ') + 1, 3) 

regexp_split_to_array

5.2* Получить информацию по покупателям с именем содержашим подстроку'jam' (независимо от регистра написания), в виде: "имя фамилия" - одной строкой.
- "||" - оператор конкатенации
- where - конструкция фильтрации
- ilike - регистронезависимый поиск
- strpos
- character_length
- overlay
- substring
- split_part

select *
from customer
where first_name ilike '%jam%'

select *
from customer
where first_name ilike '%jam%'

select *
from customer
where first_name like 'MARY'
	
6. Получить id покупателей, арендовавших фильмы в срок с 27-05-2005 по 28-05-2005 включительно
- используйте ER - диаграмму, чтобы найти подходящую таблицу
- between - задает промежуток (аналог ... >= ... and ... <= ...)
- date_part()
- date_trunc()
- interval

date 
timestamp 
time 
timestamptz
timetz
interval

show lc_collate

RU + EU
dd.mm.YYYY
YYYY.mm.dd
dd-mm-YYYY
YYYY-mm-dd
dd/mm/YYYY
YYYY/mm/dd

US
YYYY.mm.dd
mm.dd.YYYY
15.01.2022

tz - часовой пояс

01.01.2022 12:00:00.000+9 от utc

01.01.2022 12:00:00.000+6 

01.01.2022 12:00:00.000+4 

--ложный запрос
select customer_id, rental_date
from rental 
where rental_date >= '27-05-2005' and rental_date <= '28-05-2005'

--ложный запрос
select customer_id, rental_date
from rental 
where rental_date between '27-05-2005' and '28-05-2005'
order by rental_date desc

--можно, но плохо
select customer_id, rental_date
from rental 
where rental_date between '27-05-2005 00:00:00' and '29-05-2005 00:00:00'
order by rental_date desc

select customer_id, rental_date
from rental 
where rental_date between '27-05-2005 00:00:00' and '28-05-2005 24:00:00'
order by rental_date desc

select customer_id, rental_date
from rental 
where rental_date between '27-05-2005 00:00:00' and '28-05-2005'::date + interval '1 day' --+ interval '24 hours'
order by rental_date desc

--так нужно
select customer_id, rental_date
from rental 
where rental_date::date between '27-05-2005' and '28-05-2005'
order by rental_date desc

6* Вывести платежи поступившие после 2005-07-08
- используйте ER - диаграмму, чтобы найти подходящую таблицу
- > - строгое больше (< - строгое меньше)

select *
from payment
where payment_date::date > '2005-07-08'

select payment_date, 
	date_part('year', payment_date),
	date_part('month', payment_date),
	date_part('day', payment_date),
	date_part('hours', payment_date),
	date_part('isodow', payment_date)
from payment 

select payment_date, 
	date_trunc('year', payment_date),
	date_trunc('month', payment_date),
	date_trunc('day', payment_date),
	date_trunc('hours', payment_date)
from payment 

7 Получить количество дней с '30-04-2007' по сегодняшний день.
Получить количество месяцев с '30-04-2007' по сегодняшний день.
Получить количество лет с '30-04-2007' по сегодняшний день.

select now()

2022-10-24 21:42:27.147318+03

select current_time

select current_timestamp

select current_date

select current_user

select current_schema

timestamp - timestamp = interval 

date - date = integer

'01.01.2022 18:00' - '02.01.2022 10:00'
1
2/3

--дни:
select current_date - '30-04-2007'::date

--Месяцы:
select date_part('year', age(now(), '30-04-2007'::date)) * 12 + date_part('month', age(now(), '30-04-2007'::date)) 

--Года:
select round((current_date - '30-04-2007'::date)/365.25)

select date_part('year', age(now(), '30-04-2007'::date))


select *
from payment
order by payment_date

select x ::text
from (
	select x
	from generate_series(1, 12, 1) x
	order by 1) t

Булев тип

boolean / bool 

true 't' 1 'yes' 'on' 'y'

false 'f' 0 'no' 'off' 'n'
	
select customer_id, last_name, activebool --593
from customer 
where activebool --true / false

where x > 1 --true / false

select customer_id, last_name, activebool --593
from customer 
where activebool is false

8 Логические операторы and и or

оператор and имеет преимущество перед оператором or 

как в математике and - умножение or - сложение

where x > 1 and y < 2 or z = 5 or a = 4 and b < 15

where (x > 1 * y < 2) + z = 5 + (a = 4 * b < 15)

select customer_id, amount
from payment 
where customer_id < 3 and amount = 2.99 or amount = 4.99

select customer_id, amount
from payment 
where customer_id < 3 and (amount = 2.99 or amount = 4.99)


SELECT * FROM film
WHERE
	language_id  = 1
	AND rental_duration = 6
    AND upper(rating::text) like 'PG%'
    
или 

SELECT * FROM film
WHERE
	upper(rating::text) like 'PG%'
	AND rental_duration = 6
	AND language_id  = 1
	
select 
from (
	select 
	from (
		select *
		from film))
where film_id = 100

select 
from (
	select 
	from (
		select *
		from film
		where film_id = 100))

select film_id, rating
from film 
where lower(rating::text) = 'pg'

select payment_id, payment_date
from payment 
order by date_part('month', payment_date)

'07 января'
'03 февраля'
'12 марта'

select split_part('07 января', ' ', 2)

number | month 
1		январь
2 		февраль

--m3-utf8

--=============== МОДУЛЬ 3. ОСНОВЫ SQL =======================================
--= ПОМНИТЕ, ЧТО НЕОБХОДИМО УСТАНОВИТЬ ВЕРНОЕ СОЕДИНЕНИЕ И ВЫБРАТЬ СХЕМУ PUBLIC===========
SET search_path TO public;

--======== ОСНОВНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Выведите для каждого покупателя его адрес проживания, 
--город и страну проживания.





--ЗАДАНИЕ №2
--С помощью SQL-запроса посчитайте для каждого магазина количество его покупателей.





--Доработайте запрос и выведите только те магазины, 
--у которых количество покупателей больше 300-от.
--Для решения используйте фильтрацию по сгруппированным строкам 
--с использованием функции агрегации.





-- Доработайте запрос, добавив в него информацию о городе магазина, 
--а также фамилию и имя продавца, который работает в этом магазине.





--ЗАДАНИЕ №3
--Выведите ТОП-5 покупателей, 
--которые взяли в аренду за всё время наибольшее количество фильмов





--ЗАДАНИЕ №4
--Посчитайте для каждого покупателя 4 аналитических показателя:
--  1. количество фильмов, которые он взял в аренду
--  2. общую стоимость платежей за аренду всех фильмов (значение округлите до целого числа)
--  3. минимальное значение платежа за аренду фильма
--  4. максимальное значение платежа за аренду фильма





--ЗАДАНИЕ №5
--Используя данные из таблицы городов, составьте все возможные пары городов так, чтобы 
--в результате не было пар с одинаковыми названиями городов. Решение должно быть через Декартово произведение.
 




--ЗАДАНИЕ №6
--Используя данные из таблицы rental о дате выдачи фильма в аренду (поле rental_date) и 
--дате возврата (поле return_date), вычислите для каждого покупателя среднее количество 
--дней, за которые он возвращает фильмы. В результате должны быть дробные значения, а не интервал.
 




--======== ДОПОЛНИТЕЛЬНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Посчитайте для каждого фильма сколько раз его брали в аренду и значение общей стоимости аренды фильма за всё время.





--ЗАДАНИЕ №2
--Доработайте запрос из предыдущего задания и выведите с помощью него фильмы, которые отсутствуют на dvd дисках.





--ЗАДАНИЕ №3
--Посчитайте количество продаж, выполненных каждым продавцом. Добавьте вычисляемую колонку "Премия".
--Если количество продаж превышает 7300, то значение в колонке будет "Да", иначе должно быть значение "Нет".









--p3-46

============= теория =============

id_a | val_a     <- | ->     id_b | val_b | id_a

create table table_one (
	name_one varchar(255) not null
);

create table table_two (
	name_two varchar(255) not null
);

insert into table_one (name_one)
values ('one'), ('two'), ('three'), ('four'), ('five');

insert into table_two (name_two)
values ('four'), ('five'), ('six'), ('seven'), ('eight');

select * from table_one;

select * from table_two;

--left, right, inner, full outer, cross

select t1.name_one, t2.name_two
from table_one t1 
inner join table_two t2 on t1.name_one = t2.name_two

select t1.name_one, t2.name_two
from table_one t1 
join table_two t2 on t1.name_one = t2.name_two

select t1.name_one, t2.name_two
from table_one t1 
left join table_two t2 on t1.name_one = t2.name_two

select c.last_name, a.address --599
from customer c
join address a on c.address_id = a.address_id

select c.last_name, a.address --599
from customer c
left join address a on c.address_id = a.address_id

select c.last_name, a.address --599
from customer c
left join address a on c.address_id = a.address_id
where a.address_id is null

--грубая ошибка
select c.last_name, a.address --599
from customer c
left join address a on c.address_id = a.address_id
where a.address_id = null

select c.last_name, a.address --358 795
from customer c
left join address a on c.address_id != a.address_id

a1	a2
1	1
2	2
3	3

select c.last_name, a.address --596
from customer c
join address a on c.address_id = a.address_id

select customer.last_name, address.address --596
from customer 
join address on customer.address_id = address.address_id

select t1.name_one, t2.name_two
from table_one t1 
right join table_two t2 on t1.name_one = t2.name_two

select t1.name_one, t2.name_two
from table_one t1 
full join table_two t2 on t1.name_one = t2.name_two

select concat(t1.name_one, t2.name_two)
from table_one t1 
full join table_two t2 on t1.name_one = t2.name_two
where t1.name_one is null or t2.name_two is null

select t1.name_one, t2.name_two
from table_one t1 
cross join table_two t2

select t1.name_one, t2.name_two
from table_one t1, table_two t2

select t1.name_one, t2.name_two
from table_one t1, table_two t2
where t1.name_one = t2.name_two

select c1.first_name, c2.first_name --358 801
from customer c1, customer c2

select c1.first_name, c2.first_name --358 186
from customer c1, customer c2
where c1.first_name != c2.first_name

select c1.first_name, c2.first_name --179 093
from customer c1, customer c2
where c1.first_name > c2.first_name

--BARBARA		BARBARA
--ELIZABETH		ELIZABETH
--BARBARA		ELIZABETH
ELIZABETH		BARBARA	

select c1.first_name, c2.first_name --358 186
from customer c1, customer c2
where c1.first_name != c2.first_name

select 'a' > 'B'

delete from table_one;

delete from table_two;

insert into table_one (name_one)
select unnest(array[1,1,2]);

insert into table_two (name_two)
select unnest(array[1,1,3]);

select * from table_one

select * from table_two

1A	1B
1a	1b
2c	3d

1A1B
1A1b
1a1B
1a1b

select t1.name_one, t2.name_two
from table_one t1 
join table_two t2 on t1.name_one = t2.name_two

select t1.name_one, t2.name_two
from table_one t1 
left join table_two t2 on t1.name_one = t2.name_two

select t1.name_one, t2.name_two
from table_one t1 
right join table_two t2 on t1.name_one = t2.name_two

select t1.name_one, t2.name_two
from table_one t1 
full join table_two t2 on t1.name_one = t2.name_two

select t1.name_one, t2.name_two
from table_one t1, table_two t2

select count(*) --599
from customer c

select count(*) --16049
from payment p

select count(*) --16049
from customer c
join payment p on p.customer_id = c.customer_id

select count(*) --16044
from rental r

-- ЛОЖНЫЙ ЗАПРОС
select count(*) --445483
from customer c
join payment p on p.customer_id = c.customer_id
join rental r on r.customer_id = c.customer_id

--ВЕРНЫЙ ЗАПРОС
select count(*) --16049
from customer c
join payment p on p.customer_id = c.customer_id
join rental r on r.rental_id = p.rental_id

--union / except

select upper(first_name) --599
from customer 
union --distinct
select upper(first_name) --2
from staff 
--591

select upper(first_name) --599
from customer 
union all
select upper(first_name) --2
from staff 
--601	

select x, count(*)
from (
	select upper(first_name) x --599
	from customer 
	union all
	select upper(first_name) x --2
	from staff) t 
group by x
having count(*) > 1

select *
from (
	select 1 as x, 1 as y
	union all
	select 1 as x, 1 as y
	union all
	select 1 as x, 1 as y
	union all
	select 1 as x, 2 as y) t
except --distinct
select 1 as x, 1 as y

select *
from (
	select 1 as x, 1 as y
	union all
	select 1 as x, 1 as y
	union all
	select 1 as x, 1 as y
	union all
	select 1 as x, 2 as y) t
except all
select 1 as x, 1 as y

-- case

select c, count(*)
from (
	select amount, 
		case
			when amount <= 5 then 'малый платеж'
			when amount > 5 and amount <= 10 then 'средний платеж'
			else 'большой платеж'
		end	c
	from payment) t  
group by c

============= соединения =============

1. Выведите список названий всех фильмов и их языков
* Используйте таблицу film
* Соедините с language
* Выведите информацию о фильмах:
title, language."name"

select f.title, l."name"
from film f
join "language" l on f.language_id = l.language_id

1. Выведите все фильмы и их категории:
* Используйте таблицу film
* Соедините с таблицей film_category
* Соедините с таблицей category
* Соедините используя оператор using

select f.title, c."name"
from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id

select f.title, c."name"
from category c 
join film_category fc on fc.category_id = c.category_id
join film f on f.film_id = fc.film_id

select f.title, c."name"
from category c 
join film_category fc on c.category_id = fc.category_id
join film f on f.film_id = fc.film_id

select f.title, c."name", f.film_id
from film f
join film_category fc on f.film_id = fc.film_id and fc.category_id < 3
join category c on fc.category_id = c.category_id

select f.title, c."name", film_id
from film f
join film_category fc using (film_id)
join category c using (category_id)

select *
from customer c 
join store s using(store_id)
join staff s2 using(store_id) 
join address a on a.address_id = c.address_id

2. Выведите уникальный список фильмов, которые брали в аренду '24-05-2005'. 
* Используйте таблицу film
* Соедините с inventory
* Соедините с rental
* Отфильтруйте, используя where 

select distinct f.title
from film f
join inventory i on i.film_id = f.film_id
join rental r on r.inventory_id = i.inventory_id
where r.rental_date::date = '24-05-2005'

select distinct f.title
from film f
join inventory i on i.film_id = f.film_id
join rental r on r.inventory_id = i.inventory_id and r.rental_date::date = '24-05-2005'

select distinct f.title, r.rental_id
from film f
join inventory i on i.film_id = f.film_id
left join rental r on r.inventory_id = i.inventory_id and r.rental_date::date = '24-05-2005'

select *
from (
	select payment_date::date, count(*)
	from payment 
	group by payment_date::date) t1
join (
	select rental_date::date, count(*)
	from rental 
	group by rental_date::date) t2 on t1.payment_date = t2.rental_date and t1.count != t2.count

2.1 Выведите все магазины из города Woodridge (city_id = 576)
* Используйте таблицу store
* Соедините таблицу с address 
* Соедините таблицу с city 
* Соедините таблицу с country 
* отфильтруйте по "city_id"
* Выведите полный адрес искомых магазинов и их id:
store_id, postal_code, country, city, district, address, address2, phone

explain analyze --20.64

select store_id, postal_code, country, city, district, address, address2, phone
from store s
left join address a on s.address_id = a.address_id and a.city_id = 576
left join city c on c.city_id = a.city_id
left join country c2 on c2.country_id = c.country_id

explain analyze--20.64
select store_id, postal_code, country, city, district, address, address2, phone
from store s
join address a on s.address_id = a.address_id 
join city c on c.city_id = a.city_id
join country c2 on c2.country_id = c.country_id
where c.city_id = 576

============= агрегатные функции =============

sum 
count 
min 
max 
avg 
array_agg()
string_agg()

3. Подсчитайте количество актеров в фильме Grosse Wonderful (id - 384)
* Используйте таблицу film
* Соедините с film_actor
* Отфильтруйте, используя where и "film_id" 
* Для подсчета используйте функцию count, используйте actor_id в качестве выражения внутри функции
* Примените функцильные зависимости

select count(fa.actor_id)
from film_actor fa
where fa.film_id = 384

select count(1)
from film_actor fa
where fa.film_id = 384

select 'да все что угодно'
from film_actor fa
where fa.film_id = 384

select count(*), count(address_id) 
from customer c

--ложный запрос
select f.title, count(fa.actor_id)
from film_actor fa
join film f on f.film_id = fa.film_id
group by f.title

--ложный запрос
select f.title, count(fa.actor_id)
from film_actor fa
join film f on f.film_id = fa.film_id
group by f.title

--ложный запрос
select f.title, count(fa.actor_id), f.release_year, f.rental_rate, f.length
from film_actor fa
join film f on f.film_id = fa.film_id
group by f.title, f.release_year, f.rental_rate, f.length

--верный запрос
select f.title, count(fa.actor_id), f.release_year, f.rental_rate, f.length
from film_actor fa
join film f on f.film_id = fa.film_id
group by f.film_id

--верный запрос
select count(fa.actor_id), f.rental_duration, f.length
from film_actor fa
join film f on f.film_id = fa.film_id
group by f.rental_duration, f.length

Иван Иванов
Иван Иванов
Иван Иванов

ОШИБКА: столбец "f.title" должен фигурировать в предложении GROUP BY или использоваться в агрегатной функции

Хищник а
Хищник б
Хищник в
Хищник г
Хищник д

title		count
Хищник		5
Чужой		7

3.1 Посчитайте среднюю стоимость аренды за день по всем фильмам
* Используйте таблицу film
* Стоимость аренды за день rental_rate/rental_duration
* avg - функция, вычисляющая среднее значение
--4 агрегации

select round(avg(rental_rate/rental_duration), 2),
	sum(rental_rate/rental_duration),
	min(rental_rate/rental_duration),
	max(rental_rate/rental_duration)
from film 

select date_trunc('hour', payment_date), string_agg(customer_id::text, ', ')
from payment
group by 1

select date_trunc('hour', payment_date), array_agg(customer_id)
from payment
group by 1

============= группировки =============

4. Выведите месяцы, в которые было сдано в аренду более чем на 10 000 у.е.
* Используйте таблицу payment
* Сгруппируйте данные по месяцу используя date_trunc
* Для каждой группы посчитайте сумму платежей
* Воспользуйтесь фильтрацией групп, для выбора месяцев с суммой продаж более чем на 10 000 у.е.

select date_trunc('month', payment_date), sum(amount)
from payment
group by 1 
having sum(amount) > 10000

explain analyze
select date_trunc('month', payment_date), sum(amount)
from payment
group by 1 
having sum(amount) > 10000 and date_trunc('month', payment_date) < '01.08.2005'

select date_trunc('month', payment_date), sum(amount)
from payment
where date_trunc('month', payment_date) < '01.08.2005'
group by 1 
having sum(amount) > 10000 

select customer_id, date_trunc('month', payment_date), sum(amount)
from payment
where customer_id < 3
group by 1, 2 
order by 1, 2

select customer_id, staff_id, date_trunc('month', payment_date), sum(amount)
from payment
where customer_id < 3
group by 1, 2, 3
order by 1, 2, 3

select customer_id, staff_id, date_trunc('month', payment_date), sum(amount)
from payment
where customer_id < 3
group by grouping sets(1, 2, 3)
order by 1, 2, 3

create temporary table x as (
	select customer_id, staff_id, date_trunc('month', payment_date), sum(amount)
	from payment
	where customer_id < 3
	group by cube(1, 2, 3)
	order by 1, 2, 3)
	
select * from x 
where customer_id is null and staff_id is not null and date_trunc is not null

select customer_id, staff_id, date_trunc('month', payment_date), sum(amount)
from payment
where customer_id < 3
group by rollup(1, 2, 3)
order by 1, 2, 3


select coalesce(customer_id::text, 'итого'), coalesce(date_trunc::text, 'итого'), sum
from (
	select customer_id, date_trunc('month', payment_date), sum(amount)
	from payment
	where customer_id < 3
	group by cube(1, 2)
	order by 1, 2) t 
	
	янв фев март	итого	
1	65	
2
3
4
итого

4.0.1 найти сумму платежей пользователей, где размер платежа меньше 5 у.е и сумму платежей пользователей, 
	где размер платежа больше 5 у.е

select customer_id, sum(amount),
	sum(case when amount < 5 then amount end),
	sum(case when amount >= 5 then amount end)
from payment 
group by 1

select customer_id, sum(amount),
	sum(amount) filter (where amount < 5),
	sum(amount) filter (where amount >= 5)
from payment 
group by 1

--ложный запрос
select customer_id, sum(count(*))
from payment 
group by 1

select count(distinct customer_id)
from payment 


4.1 Выведите список категорий фильмов, средняя продолжительность аренды которых более 5 дней
* Используйте таблицу film
* Соедините с таблицей film_category
* Соедините с таблицей category
* Сгруппируйте полученную таблицу по category.name
* Для каждой группы посчитайте средню продолжительность аренды фильмов
* Воспользуйтесь фильтрацией групп, для выбора категории со средней продолжительностью > 5 дней

select c."name"
from category c
join film_category fc on fc.category_id = c.category_id
join film f on f.film_id = fc.film_id
group by c.category_id
having avg(f.rental_duration) > 5

============= подзапросы =============

5. Выведите количество фильмов, со стоимостью аренды за день больше, 
чем среднее значение по всем фильмам
* Напишите подзапрос, который будет вычислять среднее значение стоимости 
аренды за день (задание 3.1)
* Используйте таблицу film
* Отфильтруйте строки в результирующей таблице, используя опретаор > (подзапрос)
* count - агрегатная функция подсчета значений

скаляр  - не имеет алиаса и используется в select, условии и крайне редко в cross join
одномерный массив - не миеет алиаса используется в условиях
таблицу - обязательно алиас используется во from и join 

select title, rental_rate / rental_duration 
from film 
where rental_rate / rental_duration > (select avg(rental_rate / rental_duration ) from film)

explain analyze
select customer_id, sum(amount) * 100 / (select sum(amount) from payment)
from payment 
group by 1

6. Выведите фильмы, с категорией начинающейся с буквы "C"
* Напишите подзапрос:
 - Используйте таблицу category
 - Отфильтруйте строки с помощью оператора like 
* Соедините с таблицей film_category
* Соедините с таблицей film
* Выведите информацию о фильмах:
title, category."name"
* Используйте подзапрос во from, join, where

select category_id, "name"
from category 
where "name" like 'C%'

explain analyse 
select f.title, t.n
from (
	select category_id, "name" n
	from category c
	where "name" like 'C%') t
join film_category fc on fc.category_id = t.category_id
join film f on f.film_id = fc.film_id --175 / 53.54 / 0.38   

explain analyse
select f.title, t.name
from (
	select category_id, "name"
	from category 
	where "name" like 'C%') t 
left join film_category fc on fc.category_id = t.category_id
left join film f on f.film_id = fc.film_id --175 / 53.54 / 0.38   

explain analyse
select f.title, t.name
from film f
join film_category fc on fc.film_id = f.film_id
join (
	select category_id, "name"
	from category 
	where "name" like 'C%') t on t.category_id = fc.category_id --175 / 53.54 / 0.38 

explain analyse
select f.title, c.name
from film f
join film_category fc on fc.film_id = f.film_id and  
	fc.category_id in --(3, 4, 5)
		(select category_id
		from category 
		where "name" like 'C%') 
join category c on c.category_id = fc.category_id --175 / 47.36 / 0.34	

where x in (1,6,9,'A')

explain analyse
select f.title, c.name
from film f
join film_category fc on fc.film_id = f.film_id 
join category c on c.category_id = fc.category_id
where c.category_id in (
	select category_id
	from category 
	where "name" like 'C%') --175 / 47.21 / 0.337	
	
explain analyze
select f.title, t.name
from film f
right join film_category fc on fc.film_id = f.film_id
right join (
	select category_id, "name"
	from category 
	where "name" like 'C%') t on t.category_id = fc.category_id --175 / 53.54 / 0.43	

explain analyze
select f.title, c.name
from film f
join film_category fc on fc.film_id = f.film_id 
join category c on c.category_id = fc.category_id
where c."name" like 'C%'  --175 / 53.54	0.38

--так не надо
explain analyze
select f.title, c.name
from (
	select film_id, title
	from film) f
join (
	select film_id, category_id 
	from film_category) fc on fc.film_id = f.film_id 
join (
	select category_id, name
	from category) c on c.category_id = fc.category_id
where c.category_id in (
	select category_id
	from category 
	where "name" like 'C%')	--47.21
	
	
explain analyze
select f.title, c.name
from film f
join film_category fc on fc.film_id = f.film_id 
join category c on c.category_id = fc.category_id
where c.category_id in (
	select category_id
	from category 
	where "name" like 'C%')	--47.21
	
-- ЗА ЭТО УВОЛЬНЯЮТ
explain analyze --738210 / 670
select distinct customer_id, 
	(select sum(amount) 
	from payment p1
	where p1.customer_id = p.customer_id
	group by p1.customer_id),
	(select count(amount) 
	from payment p1
	where p1.customer_id = p.customer_id
	group by p1.customer_id),
	(select min(amount) 
	from payment p1
	where p1.customer_id = p.customer_id
	group by p1.customer_id),
	(select max(amount) 
	from payment p1
	where p1.customer_id = p.customer_id
	group by p1.customer_id),
	(select avg(amount) 
	from payment p1
	where p1.customer_id = p.customer_id
	group by p1.customer_id)
from payment p
order by 1

-- ЗА ЭТО ПРЕМИЮ ДАЮТ
explain analyze --518 / 6.3
select customer_id, sum(amount), count('все что угодно'), min(amount), max(amount), avg(amount)
from payment
group by customer_id
order by 1

select 738210 / 518

select 670 / 6.3

select t1.sum сегодня, t2.sum вчера, t1.sum - t2.sum разница
from (
	select payment_date::date, sum(amount)
	from payment
	group by 1
	order by 1) t1 
join (
	select payment_date::date, sum(amount)
	from payment
	group by 1
	order by 1) t2 on t1.payment_date = t2.payment_date - 1
	
select a, b, c, d, e, f ,j ,h ,i ..... z, sum(x)
from table 
group by a, b, c, d, e, f ,j ,h ,i ..... z

select 
from (
	select a, sum(x)
	from table 
	group by a) t 
join ....


'a'

456456

34534, 34534

--z-46-1

Задание 1.Выведите одним запросом информацию о фильмах, у которых рейтинг “R” и стоимость аренды указана от 0.00 до 3.00 включительно, 
а также фильмы c рейтингом “PG-13” и стоимостью аренды больше или равной 4.00.
Ожидаемый результат запроса: letsdocode.ru...in/2-7.png

explain analyze --77.5
select title, rating, rental_rate
from film 
where (rating = 'R' and rental_rate between 0. and 3.) or (rating = 'PG-13' and rental_rate >= 4.)

explain analyze --87.5
select title, rating, rental_rate
from film 
where (rating::text like 'R' and rental_rate between 0. and 3.) or (rating::text like 'PG-13' and rental_rate >= 4.)

Задание 2. Получите информацию о трёх фильмах с самым длинным описанием фильма.
Ожидаемый результат запроса: letsdocode.ru...in/2-8.png

select title, description, character_length(description)
from film 
order by 3 desc 
limit 3

select title, description, char_length(description)
from film 
order by 3 desc 
fetch first 3 rows with ties

Задание 3. Выведите Email каждого покупателя, разделив значение Email на 2 отдельных колонки:
в первой колонке должно быть значение, указанное до @,
во второй колонке должно быть значение, указанное после @.
Ожидаемый результат запроса: letsdocode.ru...in/2-9.png

select email, split_part(email, '@', 1), split_part(email, '@', 2)
from customer 

Задание 4. Доработайте запрос из предыдущего задания, скорректируйте значения в новых колонках: первая буква должна быть заглавной, 
остальные строчными.
Ожидаемый результат запроса: letsdocode.ru...n/2-10.png

select email, initcap(split_part(email, '@', 1)), initcap(split_part(email, '@', 2))
from customer 
order by customer_id

select email, 
	initcap(split_part(split_part(email, '@', 1), '.', 1)), lower(split_part(split_part(email, '@', 1), '.', 2)),
	initcap(split_part(email, '@', 2))
from customer
order by customer_id

explain analyze --58.23
select email, 
	concat(upper(left(split_part(email, '@', 1), 1)), lower(right(split_part(email, '@', 1), -1))),
	concat(upper(left(split_part(email, '@', 2), 1)), lower(right(split_part(email, '@', 2), -1)))
from customer 
order by customer_id

explain analyze --56.73
select email, 
	concat(upper(left(email, 1)), lower(right(split_part(email, '@', 1), -1))),
	concat(upper(left(split_part(email, '@', 2), 1)), lower(right(split_part(email, '@', 2), -1)))
from customer 
order by customer_id

explain analyze --56.73
select email, 
	concat(upper(substring(email, 1, 1)), lower(substring(split_part(email, '@', 1), 2))),
	concat(upper(substring(split_part(email, '@', 2), 1, 1)), lower(substring(split_part(email, '@', 2), 2)))
from customer 
order by customer_id

explain analyze --53.73
select customer_id, email,
split_part(overlay(upper(email) placing lower(right(email,-1)) from 2),'@',1) "email before @",
overlay(lower(split_part(email, '@', 2)) placing upper(left(split_part(email, '@', 2), 1)) from 1 for 1)
from customer
order by customer_id

explain analyze --53.73
select email, 
	overlay(lower(split_part(email, '@', 1)) placing upper(left(email, 1)) from 1 for 1),
	overlay(lower(split_part(email, '@', 2)) placing upper(left(split_part(email, '@', 2), 1)) from 1 for 1)
from customer 
order by customer_id


1. в чем отличие использования разных операторов при получении одного результата

explain analyze --16.49 / 0.062
select *
from customer
where first_name = 'MARY'

explain analyze --16.49 / 0.068
select *
from customer
where first_name like 'MARY'


2. работа логических операторов

select title, rating, rental_rate
from film 
where (rating = 'R' and rental_rate between 0. and 3.) or (rating = 'PG-13' and rental_rate >= 4.)

SELECT 'Hello' || ' ' || 'world!' -- Hello world!

SELECT CONCAT('Hello', ' ', 'world!')

explain analyze --22.40 / .197
select distinct first_name
from customer 
--HashAggregate  (cost=16.49..22.40 rows=591 width=6) (actual time=0.155..0.199 rows=591 loops=1)

explain analyze --22.40 / .197

select first_name, count(*)
from customer
group by 1
having  count(*) > 1
--HashAggregate  (cost=16.49..22.40 rows=591 width=6) (actual time=0.151..0.199 rows=591 loops=1)

explain analyze --213.82
select distinct f.film_id, f.title
from film f
join film_actor fa on f.film_id = fa.film_id

explain analyze --200.17
select f.film_id, f.title
from film f
join film_actor fa on f.film_id = fa.film_id
group by f.film_id

select customer_id
from payment 
group by 1

select distinct customer_id, sum(amount)
from payment 

explain analyze --394.86
select customer_id, count(payment_id)
from payment 
group by 1
order by 1

explain analyze --1913.16
select distinct customer_id, count(payment_id) over (partition by customer_id)
from payment 
order by 1

round(numeric, int)
round(float)

Задание 1. Посчитайте для каждого фильма, сколько раз его брали в аренду, а также общую стоимость аренды фильма за всё время.
Ожидаемый результат запроса: letsdocode.ru...in/3-7.png

explain analyze --2904.85 / 23
select f.title, c."name", l."name", count(r.rental_id), sum(p.amount)
from film f
left join inventory i on i.film_id = f.film_id
left join rental r on r.inventory_id = i.inventory_id
left join payment p on p.rental_id = r.rental_id
left join film_category fc on f.film_id = fc.film_id
left join category c on c.category_id = fc.category_id
left join "language" l on l.language_id = f.language_id
group by f.film_id, c.category_id, l.language_id

explain analyze --1276.94 / 14
select f.title, c."name", l."name", i.count, i.sum
from film f
left join ( 
	select i.film_id, count(r.rental_id), sum(p.amount)
	from inventory i 
	left join rental r on r.inventory_id = i.inventory_id
	left join payment p on p.rental_id = r.rental_id
	group by i.film_id) i on i.film_id = f.film_id
left join film_category fc on f.film_id = fc.film_id
left join category c on c.category_id = fc.category_id
left join "language" l on l.language_id = f.language_id

Задание 2. Доработайте запрос из предыдущего задания и выведите с помощью него фильмы, которые ни разу не брали в аренду.
Ожидаемый результат запроса: letsdocode.ru...in/3-8.png

explain analyze --2944 / 23
select f.title, c."name", l."name", count(r.rental_id), sum(p.amount)
from film f
left join inventory i on i.film_id = f.film_id
left join rental r on r.inventory_id = i.inventory_id
left join payment p on p.rental_id = r.rental_id
left join film_category fc on f.film_id = fc.film_id
left join category c on c.category_id = fc.category_id
left join "language" l on l.language_id = f.language_id
group by f.film_id, c.category_id, l.language_id
having count(r.rental_id) = 0

explain analyze --592.48 / 3
select f.title, c."name", l."name", count(r.rental_id), sum(p.amount)
from film f
left join inventory i on i.film_id = f.film_id
left join rental r on r.inventory_id = i.inventory_id
left join payment p on p.rental_id = r.rental_id
left join film_category fc on f.film_id = fc.film_id
left join category c on c.category_id = fc.category_id
left join "language" l on l.language_id = f.language_id
where i.film_id is null
group by f.film_id, c.category_id, l.language_id

explain analyze --1312 / 13
select f.title, c."name", l."name", i.count, i.sum
from film f
left join ( 
	select i.film_id, count(r.rental_id), sum(p.amount)
	from inventory i 
	left join rental r on r.inventory_id = i.inventory_id
	left join payment p on p.rental_id = r.rental_id
	group by i.film_id) i on i.film_id = f.film_id
left join film_category fc on f.film_id = fc.film_id
left join category c on c.category_id = fc.category_id
left join "language" l on l.language_id = f.language_id
where i.film_id is null

explain analyze --599 / 3
select f.title, c."name", l."name", f.count, f.sum
from ( 
	select f.film_id, f.language_id, f.title, count(r.rental_id), sum(p.amount)
	from film f
	left join inventory i on i.film_id = f.film_id
	left join rental r on r.inventory_id = i.inventory_id
	left join payment p on p.rental_id = r.rental_id
	where i.film_id is null
	group by f.film_id) f 
left join film_category fc on f.film_id = fc.film_id
left join category c on c.category_id = fc.category_id
left join "language" l on l.language_id = f.language_id

Задание 3. Посчитайте количество продаж, выполненных каждым продавцом. Добавьте вычисляемую колонку «Премия». 
Если количество продаж превышает 7 300, то значение в колонке будет «Да», иначе должно быть значение «Нет».
Ожидаемый результат запроса: letsdocode.ru...in/3-9.png

select s.staff_id, count(p.payment_id),
	case
		when count(p.payment_id) > 7300 then 'yes'
		else 'no'
	end
from staff s
left join payment p on s.staff_id = p.staff_id
group by s.staff_id



explain analyze --36.03
select c2.customer_id, sum(p.amount)
from city c
join address a on c.city_id = a.city_id
join customer c2 on c2.address_id = a.address_id
join payment p on p.customer_id = c2.customer_id
where left(c.city, 1) = 'P'
group by 1

explain analyze --404.35
select p.*
from (
	select c2.customer_id
	from city c
	join address a on c.city_id = a.city_id
	join customer c2 on c2.address_id = a.address_id
	where left(c.city, 1) = 'P') t
join (
	select customer_id, sum(amount)
	from payment
	group by 1) p on p.customer_id = t.customer_id


select c2.customer_id, sum(amount)
from city c
join address a on c.city_id = a.city_id
join customer c2 on c2.address_id = a.address_id
join store s on c2.store_id = s.store_id
join staff s2 on s2.staff_id = s.manager_staff_id
join payment p on p.staff_id = s2.staff_id
where left(c.city, 1) = 'P'
group by 1


explain analyze --555
select c2.customer_id, sum(p.amount)
from city c
join address a on c.city_id = a.city_id
join customer c2 on c2.address_id = a.address_id
join payment p on p.customer_id = c2.customer_id
group by 1

explain analyze --438
select p.*
from city c
join address a on c.city_id = a.city_id
join customer c2 on c2.address_id = a.address_id
join (
	select customer_id, sum(amount)
	from payment
	group by 1) p on p.customer_id = c2.customer_id
	
select emp_id, project_id, sum(hours)
from hours 
group by emp_id, project_id
order by 1, 2

explain analyze --73.97
select t1.emp_id, t1.sum, t2.project_id, t2.sum
from (
	select emp_id, sum(hours), 1 as x
	from hours
	group by emp_id) t1
full join (
	select project_id, sum(hours), 2 as y
	from hours
	group by project_id) t2 on t1.x = t2.y

explain analyze --36.84
select emp_id, project_id, sum(hours)
from hours 
group by grouping sets(emp_id, project_id)

select *
from (
	select emp_id, project_id, sum(hours)
	from hours 
	group by grouping sets(emp_id, project_id)) t 
where project_id is null

select emp_id, project_id, sum(hours)
from hours 
group by cube(emp_id, project_id)

select emp_id, project_id, sum(hours)
from hours 
group by emp_id, project_id
order by 1, 2

select project_id, sum(hours)
from hours 
group by project_id
order by 1

select emp_id, sum(hours)
from hours 
group by emp_id
order by 1

select sum(hours)
from hours 


--m4-utf8

--=============== МОДУЛЬ 4. УГЛУБЛЕНИЕ В SQL =======================================
--= ПОМНИТЕ, ЧТО НЕОБХОДИМО УСТАНОВИТЬ ВЕРНОЕ СОЕДИНЕНИЕ И ВЫБРАТЬ СХЕМУ PUBLIC===========
SET search_path TO public;

--======== ОСНОВНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--База данных: если подключение к облачной базе, то создаёте новую схему с префиксом в --виде фамилии, название должно быть на латинице в нижнем регистре и таблицы создаете --в этой новой схеме, если подключение к локальному серверу, то создаёте новую схему и --в ней создаёте таблицы.

--Спроектируйте базу данных, содержащую три справочника:
--· язык (английский, французский и т. п.);
--· народность (славяне, англосаксы и т. п.);
--· страны (Россия, Германия и т. п.).
--Две таблицы со связями: язык-народность и народность-страна, отношения многие ко многим. Пример таблицы со связями — film_actor.
--Требования к таблицам-справочникам:
--· наличие ограничений первичных ключей.
--· идентификатору сущности должен присваиваться автоинкрементом;
--· наименования сущностей не должны содержать null-значения, не должны допускаться --дубликаты в названиях сущностей.
--Требования к таблицам со связями:
--· наличие ограничений первичных и внешних ключей.

--В качестве ответа на задание пришлите запросы создания таблиц и запросы по --добавлению в каждую таблицу по 5 строк с данными.
 
--СОЗДАНИЕ ТАБЛИЦЫ ЯЗЫКИ



--ВНЕСЕНИЕ ДАННЫХ В ТАБЛИЦУ ЯЗЫКИ



--СОЗДАНИЕ ТАБЛИЦЫ НАРОДНОСТИ



--ВНЕСЕНИЕ ДАННЫХ В ТАБЛИЦУ НАРОДНОСТИ



--СОЗДАНИЕ ТАБЛИЦЫ СТРАНЫ



--ВНЕСЕНИЕ ДАННЫХ В ТАБЛИЦУ СТРАНЫ



--СОЗДАНИЕ ПЕРВОЙ ТАБЛИЦЫ СО СВЯЗЯМИ



--ВНЕСЕНИЕ ДАННЫХ В ТАБЛИЦУ СО СВЯЗЯМИ



--СОЗДАНИЕ ВТОРОЙ ТАБЛИЦЫ СО СВЯЗЯМИ



--ВНЕСЕНИЕ ДАННЫХ В ТАБЛИЦУ СО СВЯЗЯМИ



--======== ДОПОЛНИТЕЛЬНАЯ ЧАСТЬ ==============


--ЗАДАНИЕ №1 
--Создайте новую таблицу film_new со следующими полями:
--·   	film_name - название фильма - тип данных varchar(255) и ограничение not null
--·   	film_year - год выпуска фильма - тип данных integer, условие, что значение должно быть больше 0
--·   	film_rental_rate - стоимость аренды фильма - тип данных numeric(4,2), значение по умолчанию 0.99
--·   	film_duration - длительность фильма в минутах - тип данных integer, ограничение not null и условие, что значение должно быть больше 0
--Если работаете в облачной базе, то перед названием таблицы задайте наименование вашей схемы.



--ЗАДАНИЕ №2 
--Заполните таблицу film_new данными с помощью SQL-запроса, где колонкам соответствуют массивы данных:
--·       film_name - array['The Shawshank Redemption', 'The Green Mile', 'Back to the Future', 'Forrest Gump', 'Schindlers List']
--·       film_year - array[1994, 1999, 1985, 1994, 1993]
--·       film_rental_rate - array[2.99, 0.99, 1.99, 2.99, 3.99]
--·   	  film_duration - array[142, 189, 116, 142, 195]



--ЗАДАНИЕ №3
--Обновите стоимость аренды фильмов в таблице film_new с учетом информации, 
--что стоимость аренды всех фильмов поднялась на 1.41



--ЗАДАНИЕ №4
--Фильм с названием "Back to the Future" был снят с аренды, 
--удалите строку с этим фильмом из таблицы film_new



--ЗАДАНИЕ №5
--Добавьте в таблицу film_new запись о любом другом новом фильме



--ЗАДАНИЕ №6
--Напишите SQL-запрос, который выведет все колонки из таблицы film_new, 
--а также новую вычисляемую колонку "длительность фильма в часах", округлённую до десятых



--ЗАДАНИЕ №7 
--Удалите таблицу film_new

--p4-46

create database название

create schema lecture_4

set search_path to lecture_4

======================== Создание таблиц ========================
1. Создайте таблицу "автор" с полями:
- id 
- имя
- псевдоним (может не быть)
- дата рождения
- город рождения
- родной язык
* Используйте 
    CREATE TABLE table_name (
        column_name TYPE column_constraint,
    );
* для id подойдет serial, ограничение primary key
* Имя и дата рождения - not null
* город и язык - внешние ключи

create table author (
	author_id serial primary key, --суррогат
	author_name varchar(100) not null,
	nick_name varchar(50),
	born_date date not null check(date_part('year', born_date) > 1800 and born_date < current_date),
	city_id int2 not null references city (city_id),
	--language_id int2 not null references language (language_id),
	created_at timestamp not null default now(),
	created_user varchar(50) not null default current_user,
	deleted boolean default false
	--deleted int2 check(deleted in (0, 1)) default 0
)

select distinct city_name --Москва
from author

10 - 100 = 55
10 - 500 = 255 

serial = integer + sequence + nextval(sequence) = автоинкремент

select *
from author
where deleted 

id char(24)

id | table_name | gen_id | crypt |

uuid 

create table a (
	id uuid default uuid_generate_v4(),
	val text
)

insert into a (val)
values ('a')

create extension "uuid-ossp"

select uuid_generate_v4()

1*  Создайте таблицы "Язык", "Город", "Страна".
* для id подойдет serial, ограничение primary key
* названия - not null и проверка на уникальность

create table city (
	city_id serial2 primary key,
	city_name varchar(50) not null,
	country_id int2 not null references country(country_id))
	
create table country (
	country_id serial2 primary key,
	country_name varchar(50) not null unique)
	
create table language (
	language_id serial2 primary key,
	language_name varchar(50) not null unique)
	
check (char_length(phone_number) = 11)	

== Отношения ==
А		Б
один к одному  		Б является атрибутом А
один ко многим		А и Б два отдельных справочника
многие ко многим	в реляционной модели не существует, реализуется через два отношения один ко многим А-В и В-Б

--ТАК ДЕЛАТЬ НЕЛЬЗЯ, ПЛОХО, ПИШЕМ ТОЛЬКО ДЛЯ ПРАКТИКИ И ПОНИМАНИЯ
create table author_language (
	author_id int2 references author(author_id) unique,
	language_id int2 references language(language_id) unique)
	
a_id | l_id 
1		2
2		1
3		3
4		7

--ТАК ДЕЛАТЬ НЕЛЬЗЯ, ПЛОХО, ПИШЕМ ТОЛЬКО ДЛЯ ПРАКТИКИ И ПОНИМАНИЯ
create table author_language (
	author_id int2 references author(author_id),
	language_id int2 references language(language_id) unique)
	
a_id | l_id 
1		2
1		1
1		3
1		7

--ТАК ДЕЛАТЬ НЕЛЬЗЯ, ПЛОХО, ПИШЕМ ТОЛЬКО ДЛЯ ПРАКТИКИ И ПОНИМАНИЯ
create table author_language (
	author_id int2 references author(author_id) unique,
	language_id int2 references language(language_id))
	
a_id | l_id 
1		2
2		2
3		2
4		2

--ТАК ДЕЛАТЬ НУЖНО
create table author_language (
	author_id int2 references author(author_id),
	language_id int2 references language(language_id)
	primary key (author_id, language_id))
	
a_id | l_id 
1		3
1		2
2		2
2		3

insert into (a_id, l_id)
values (1, 3), (1, 2)

insert into (a_id, l_id)
values ((select a_id from author where a_name = 'Пушкин'), (select l_id from language where l_name = 'русский'))

======================== Заполнение таблицы ========================

2. Вставьте данные в таблицу с языками:
'Русский', 'Французский', 'Японский'
* Можно вставлять несколько строк одновременно:
    INSERT INTO table (column1, column2, …)
    VALUES
     (value1, value2, …),
     (value1, value2, …) ,...;

select * from "language" 

insert into language (language_name)
values ('Русский'), ('Французский'), ('Японский')

insert into language 
values (4, 'Канадский')

SQL Error [22P02]: ОШИБКА: неверный синтаксис для типа smallint: "Канадский"

insert into language (language_name)
values ('Немецкий')

SQL Error [23505]: ОШИБКА: повторяющееся значение ключа нарушает ограничение уникальности "language_pkey"
  Подробности: Ключ "(language_id)=(4)" уже существует.
  
insert into language 
values (200, 'Китайский')

insert into language 
values (100, 'Голландский')

-- демонстрация работы счетчика и сброс счетчика

alter sequence language_language_id_seq restart with 201

insert into language (language_name)
values ('Украинский')

select * from lecture_4.language_language_id_seq

drop table language

create table language (
	language_id int2 primary key generated always as identity,
	language_name varchar(50) not null unique)

--Работает начиная с 13 версии PostgreSQL

create table b (
	id int primary key generated always as identity,
	qty int,
	amount numeric,
	res numeric generated always as (round(qty * amount / 1.2, 2)) stored
)

drop table b

insert into b (qty, amount)
values (5, 100), (3, 300)

select * from b

2.1 Вставьте данные в таблицу со странами из таблиц country базы dvd-rental:

select * from country

insert into country (country_name)
select country from public.country order by country_id

2.2 Вставьте данные в таблицу с городами соблюдая связи из таблиц city базы dvd-rental:

insert into city (city_name, country_id)
select distinct on(city) city, country_id from public.city 

insert into city (city_name, country_id)
select city, country_id from public.city 

select * 
from city c
join country c2 on c2.country_id = c.country_id

2.3 Вставьте данные в таблицу с авторами, идентификаторы языков и городов оставьте пустыми.
Жюль Верн, 08.02.1828
Михаил Лермонтов, 03.10.1814
Харуки Мураками, 12.01.1949

insert into author (author_name, nick_name, born_date, city_id)
values ('Жюль Верн', null, '08.02.1828', 100),
	('Михаил Лермонтов', 'Диарбекир', '03.10.1814', 200),
	('Харуки Мураками', null, '12.01.1949', 300)

select * from author
	
SQL Error [23514]: ОШИБКА: новая строка в отношении "author" нарушает ограничение-проверку "author_born_date_check"
  Подробности: Ошибочная строка содержит (2, Михаил Лермонтов, Диарбекир, 1514-10-03, 200, 2022-10-31 20:31:06.32695, postgres, f).

======================== Модификация таблицы ========================

3. Добавьте поле "идентификатор языка" в таблицу с авторами
* ALTER TABLE table_name 
  ADD COLUMN new_column_name TYPE;

 -- добавление нового столбца

alter table author add column language_id int2

select * from author

-- удаление столбца

alter table author drop column language_id 

-- добавление ограничения not null

alter table author alter column language_id set not null

-- удаление ограничения not null

alter table author alter column language_id drop not null

-- добавление ограничения unique

alter table author add constraint a_name_uni unique (author_name)

-- удаление ограничения unique

alter table author drop constraint a_name_uni

-- изменение типа данных столбца

alter table author alter column language_id type text

читаем данные из таблицы
записываем данные во временную таблицу
удаляем данные из таблиц
меняем тип данных в таблице
вносит данные в таблицу из временной таблицы --ошибка

alter table author alter column language_id type int2 using (language_id::int2)

читаем данные из таблицы
приводим к новому типу --ошибка
записываем данные во временную таблицу
удаляем данные из таблиц
меняем тип данных в таблице
вносит данные в таблицу из временной таблицы 

alter table author alter column author_name type varchar(200)

читаем данные из таблицы
записываем данные во временную таблицу
удаляем данные из таблиц
меняем тип данных в таблице
фрагментируем жесткий под новый размер варчар
вносит данные в таблицу из временной таблицы 

update pg_catalog.pg_attribute
set atttypmod = 100 + 4
where attrelid = 'author'::regclass and attname = 'author_name'

select * from pg_catalog.pg_attribute

сделали подмену в метаданных

 3* В таблице с авторами измените колонку language_id - внешний ключ - ссылка на языки
 * ALTER TABLE table_name ADD CONSTRAINT constraint_name constraint_definition

alter table author add constraint author_language_fkey foreign key (language_id) references language (language_id)
 
-- удаление ограничения внешнего ключа

alter table author drop constraint author_language_fkey

 ======================== Модификация данных ========================

4. Обновите данные, проставив корректное языки писателям:
Жюль Габриэль Верн - Французский
Михаил Юрьевич Лермонтов - Российский
Харуки Мураками - Японский
* UPDATE table
  SET column1 = value1,
   column2 = value2 ,...
  WHERE
   condition;

select * from author a

3	Жюль Верн
4	Михаил Лермонтов
5	Харуки Мураками

select * from "language" l

1	Русский
2	Французский
3	Японский

update author
set language_id = 2
where author_id = 3

update author
set language_id = 1

update author
set language_id = 3
where author_id in (3, 5)

update author
set language_id = 2, nick_name = 'отсутствует', deleted = true
where author_id = 3

update author
set language_id = 2, nick_name = 'отсутствует', deleted = true
where author_id = (select author_id from author where author_name = 'Жюль Верн')

 ======================== Удаление данных ========================
 
5. Удалите Лермонтова

delete from author
where author_id = 4

5.1 Удалите все города

delete from city 

QL Error [23503]: ОШИБКА: UPDATE или DELETE в таблице "city" нарушает ограничение внешнего ключа "author_city_id_fkey" таблицы "author"
  Подробности: На ключ (city_id)=(100) всё ещё есть ссылки в таблице "author".
 
delete - удалить записи = сканирование данных + создание новой версии + когда-нибудь потом придет vacuum и удалит с жесткого
truncate - удалить записи = удалит с жесткого

drop - удалить сущность (таблицу, ограничение, столбец)
  
select * from city c

drop table country cascade

select * from country c

drop родитель cascade - удалит ограничение внешнего ключа
truncate родитель cascade - удалит данные в дочерней таблице
родитель on delete cascade - удалит данные в дочерней таблице

create table city (
	city_id serial2 primary key,
	city_name varchar(50) not null,
	country_id int2 references country(country_id) on delete set null)
	
create table city (
	city_id serial2 primary key,
	city_name varchar(50) not null,
	country_id int2 references country(country_id) on delete cascade)
	
create table схема.city (
	city_id serial2 primary key,
	city_name varchar(50) not null,
	country_id int2 references country(country_id) on delete restrict) -- on delete no action
	
create table country (
	country_id serial2 primary key,
	country_name varchar(50) not null unique)
	
insert into country (country_name)
select country from public.country order by country_id

insert into city (city_name, country_id)
select city, country_id from public.city 

truncate country cascade

delete from country

val int check (val > 0)

drop schema lecture_4 cascade

drop database 
----------------------------------------------------------------------------

explain analyze --88.59 / 24
SELECT nspname || '.' || relname AS "relation",
	pg_size_pretty(pg_relation_size(C.oid)) AS "size"
FROM pg_class C
LEFT JOIN pg_namespace N ON (N.oid = C.relnamespace)
WHERE nspname NOT IN ('pg_catalog', 'information_schema')
ORDER BY pg_relation_size(C.oid) DESC

create temporary table a as (
	SELECT nspname || '.' || relname AS "relation",
	pg_size_pretty(pg_relation_size(C.oid)) AS "size"
FROM pg_class C
LEFT JOIN pg_namespace N ON (N.oid = C.relnamespace)
WHERE nspname NOT IN ('pg_catalog', 'information_schema')
ORDER BY pg_relation_size(C.oid) DESC)

explain analyze --18.8 / 0.028
select * from a

select 24 / 0.028



create table payment_new (like payment)

create table payment_temp (like payment including all)

create table payment_new (like payment) partition by range (amount)

create table payment_low partition of payment_new for values from (minvalue) to (5)

create table payment_middle partition of payment_new for values from (5) to (10)

create table payment_high partition of payment_new for values from (10) to (maxvalue)

insert into payment_new
select * from payment

select *
from only payment_new

explain analyze --320.94 / 1.9
select distinct customer_id
from payment 
where amount > 10

explain analyze --3.85 / 0.054
select distinct customer_id
from payment_new 
where amount > 10

select 320.94 / 3.85 --83

select 1.9 / 0.054 --35

explain analyze --355 / 3.7
select distinct customer_id
from payment 
where amount < 5

explain analyze --272 / 4.6
select distinct customer_id
from payment_new 
where amount < 5



create table customer_new (like customer) partition by list (lower(left(last_name, 1)))

create table customer_a_g partition of customer_new for values in ('a', 'b', 'c', 'd', 'e', 'f', 'g')

create table customer_h_l partition of customer_new for values in ('h', 'k', 'l')

insert into customer_new

create temporary table c as (
select * 
from customer 
where lower(left(last_name, 1)) in ('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'k', 'l'))

explain analyze --13.68 / 0.117
select *
from c 
where lower(left(last_name, 1)) = 'b'

explain analyze --7.94 / 0.092
select *
from customer_new
where lower(left(last_name, 1)) = 'b'

unnest

--m5-utf8

--=============== МОДУЛЬ 5. РАБОТА С POSTGRESQL =======================================
--= ПОМНИТЕ, ЧТО НЕОБХОДИМО УСТАНОВИТЬ ВЕРНОЕ СОЕДИНЕНИЕ И ВЫБРАТЬ СХЕМУ PUBLIC===========
SET search_path TO public;

--======== ОСНОВНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Сделайте запрос к таблице payment и с помощью оконных функций добавьте вычисляемые колонки согласно условиям:
--Пронумеруйте все платежи от 1 до N по дате платежа
--Пронумеруйте платежи для каждого покупателя, сортировка платежей должна быть по дате платежа
--Посчитайте нарастающим итогом сумму всех платежей для каждого покупателя, сортировка должна 
--быть сперва по дате платежа, а затем по размеру платежа от наименьшей к большей
--Пронумеруйте платежи для каждого покупателя по размеру платежа от наибольшего к
--меньшему так, чтобы платежи с одинаковым значением имели одинаковое значение номера.
--Можно составить на каждый пункт отдельный SQL-запрос, а можно объединить все колонки в одном запросе.




--ЗАДАНИЕ №2
--С помощью оконной функции выведите для каждого покупателя стоимость платежа и стоимость 
--платежа из предыдущей строки со значением по умолчанию 0.0 с сортировкой по дате платежа.





--ЗАДАНИЕ №3
--С помощью оконной функции определите, на сколько каждый следующий платеж покупателя больше или меньше текущего.





--ЗАДАНИЕ №4
--С помощью оконной функции для каждого покупателя выведите данные о его последней оплате аренды.





--======== ДОПОЛНИТЕЛЬНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--С помощью оконной функции выведите для каждого сотрудника сумму продаж за август 2005 года 
--с нарастающим итогом по каждому сотруднику и по каждой дате продажи (без учёта времени) 
--с сортировкой по дате.




--ЗАДАНИЕ №2
--20 августа 2005 года в магазинах проходила акция: покупатель каждого сотого платежа получал
--дополнительную скидку на следующую аренду. С помощью оконной функции выведите всех покупателей,
--которые в день проведения акции получили скидку




--ЗАДАНИЕ №3
--Для каждой страны определите и выведите одним SQL-запросом покупателей, которые попадают под условия:
-- 1. покупатель, арендовавший наибольшее количество фильмов
-- 2. покупатель, арендовавший фильмов на самую большую сумму
-- 3. покупатель, который последним арендовал фильм








--p5-46
--шаблон окна
--функция(аргумент) over (partition by ... order by ...)

/*
Отличие группировки от окна
    
customer_id | sum(amount)
1				5
1				2
1				3
1				5
2				3
2				1
2				3

group by 
1				15
2				7

partition by 
1				5		15
1				2		15
1				3		15
1				5		15
2				3		7
2				1		7
2				3		7
*/


from 
on 
join 
where 
group by 
having 
over 
select customer_id, amount, окно

============= оконные функции =============

1. Вывести ФИО пользователя и название третьего фильма, который он брал в аренду.
* В подзапросе получите порядковые номера для каждого пользователя по дате аренды
* Задайте окно с использованием предложений over, partition by и order by
* Соедините с customer
* Соедините с inventory
* Соедините с film
* В условии укажите 3 фильм по порядку

--explain analyze --1934
select customer_id, f.title
from (
	select customer_id, array_agg(inventory_id)
	from (
		select customer_id, rental_date, inventory_id
		from "dvd-rental".rental 
		order by customer_id, rental_date) t 
	group by 1) t
join "dvd-rental".inventory i on i.inventory_id = t.array_agg[3]
join "dvd-rental".film f on f.film_id = i.film_id

--explain analyze --2108
select customer_id, f.title
from (
	select customer_id, rental_date, inventory_id, row_number() over (partition by customer_id order by rental_date)
	from "dvd-rental".rental) t
join "dvd-rental".inventory i on i.inventory_id = t.inventory_id
join "dvd-rental".film f on f.film_id = i.film_id	
where row_number = 3

1.1. Выведите таблицу, содержащую имена покупателей, арендованные ими фильмы и средний платеж 
каждого покупателя
* используйте таблицу customer
* соедините с paymen
* соедините с rental
* соедините с inventory
* соедините с film
* avg - функция, вычисляющая среднее значение
* Задайте окно с использованием предложений over и partition by

select c.last_name, f.title, amount, avg(p.amount) over (partition by c.customer_id)
from customer c
join payment p on p.customer_id = c.customer_id
join rental r on p.rental_id = r.rental_id
join inventory i on i.inventory_id = r.rental_id
join film f on f.film_id = i.film_id

select c.last_name, f.title, amount, 
	avg(p.amount) over (partition by c.customer_id),
	count(p.amount) over (partition by c.customer_id),
	sum(p.amount) over (partition by c.customer_id),
	min(p.amount) over (partition by c.customer_id),
	max(p.amount) over (partition by c.customer_id),
	avg(p.amount) over (),  --пустые скобки означают что по берутся окна по всему объему 
	count(p.amount) over (), -- т.е. без каких-то групп и сортировок
	sum(p.amount) over (),
	min(p.amount) over (),
	max(p.amount) over ()
from "dvd-rental".customer c
join "dvd-rental".payment p on p.customer_id = c.customer_id
join "dvd-rental".rental r on p.rental_id = r.rental_id
join "dvd-rental".inventory i on i.inventory_id = r.rental_id
join "dvd-rental".film f on f.film_id = i.film_id

select customer_id, sum(amount) * 100 / (select sum(amount) from "dvd-rental".payment) 
from "dvd-rental".payment 
group by 1

select customer_id, sum(amount) * 100 / sum(sum(amount)) over () -- работаем со всем объемом данных
from "dvd-rental".payment 
group by 1

select c.last_name, f.title, amount, date_trunc('month', p.payment_date),
	avg(p.amount) over (partition by c.customer_id),
	count(p.amount) over (partition by c.customer_id),
	sum(p.amount) over (partition by c.customer_id),
	min(p.amount) over (partition by c.customer_id),
	max(p.amount) over (partition by c.customer_id),
	avg(p.amount) over (),
	count(p.amount) over (),
	sum(p.amount) over (partition by c.customer_id, date_trunc('month', p.payment_date)), --отельно по месяцам
	min(p.amount) over (),
	max(p.amount) over ()
from "dvd-rental".customer c
join "dvd-rental".payment p on p.customer_id = c.customer_id
join "dvd-rental".rental r on p.rental_id = r.rental_id
join "dvd-rental".inventory i on i.inventory_id = r.rental_id
join "dvd-rental".film f on f.film_id = i.film_id

-- filter работает только с агрегатными функиями

--хотим получить сумму платежей
select customer_id, sum(amount) over (), --общая
	sum(amount) filter (where amount <= 5) over (partition by customer_id), --для которых amount <= 5
	sum(amount) filter (where amount > 5) over (partition by customer_id)  --для которых amount > 5
from "dvd-rental".payment 

-- формирование накопительного итога

select customer_id, payment_date, amount, sum(amount) over (partition by customer_id order by payment_date)
from "dvd-rental".payment 

select customer_id, payment_date, amount, avg(amount) over (partition by customer_id order by payment_date)
from "dvd-rental".payment 

select customer_id, payment_date::date, amount, sum(amount) over (partition by customer_id order by payment_date::date)
from "dvd-rental".payment 
 
select customer_id, payment_date::date, amount, avg(amount) over (partition by customer_id order by payment_date::date)
from "dvd-rental".payment 

-- работа функций lead и lag сортировка при этом обязательна!

select customer_id, payment_date, 
	lag(amount) over (partition by customer_id order by payment_date),
	amount, 
	lead(amount) over (partition by customer_id order by payment_date)
from "dvd-rental".payment 

select customer_id, payment_date, 
	amount, lag(amount) over (partition by customer_id order by payment_date),
	amount - lag(amount) over (partition by customer_id order by payment_date)
from "dvd-rental".payment 

--добавление шага
select customer_id, payment_date, 
	lag(amount, 3) over (partition by customer_id order by payment_date),
	amount, 
	lead(amount, 5) over (partition by customer_id order by payment_date)
from "dvd-rental".payment 

--добавление значений по умолчанию вместо null
select customer_id, payment_date, 
	lag(amount, 3, 0.) over (partition by customer_id order by payment_date),
	amount, 
	lead(amount, 5, 0.) over (partition by customer_id order by payment_date)
from "dvd-rental".payment 

select date_trunc('month', payment_date), sum (amount),
	sum (amount) - lag(sum (amount)) over (order by date_trunc('month', payment_date))
from "dvd-rental".payment 
group by 1

-- работа с рангами и порядковыми номерами

select customer_id, payment_date::date, amount, 
	row_number() over (partition by customer_id order by payment_date::date, amount), --нумерация всего подряд
	rank() over (partition by customer_id order by payment_date::date),  --текущий ранг + количество строк данного ранга
	dense_rank() over (partition by customer_id order by payment_date::date)  --ранжирование по уникальному значению
from "dvd-rental".payment 

select *
from (
	select customer_id, payment_date::date, amount, 
		row_number() over (partition by customer_id order by payment_date::date),
		rank() over (partition by customer_id order by payment_date::date),
		dense_rank() over (partition by customer_id order by payment_date::date)
	from "dvd-rental".payment) t
where row_number between 5 and 7

--для каждого пользоватля по три записи между 5 и 7
select *
from (
	select customer_id, payment_date::date, amount, 
		row_number() over (partition by customer_id order by payment_date::date),
		rank() over (partition by customer_id order by payment_date::date),
		dense_rank() over (partition by customer_id order by payment_date::date)
	from "dvd-rental".payment) t
where dense_rank between 5 and 7

-- last_value / first_value / nth_value

--использовать last_value не желательно.

--explain analyze --1480
select distinct on (customer_id) customer_id, payment_date, amount
from "dvd-rental".payment
order by customer_id, payment_date desc

--explain analyze --744
select payment_id, customer_id, payment_date, amount
from "dvd-rental".payment
where (customer_id, payment_date) in (select customer_id, max(payment_date) from "dvd-rental".payment group by customer_id) --двойное сравнение

--explain analyze --1987
select distinct customer_id, 
	first_value(payment_date) over (partition by customer_id order by payment_date desc),
	first_value(amount) over (partition by customer_id order by payment_date desc),
	first_value(rental_id) over (partition by customer_id order by payment_date desc)
from "dvd-rental".payment

--explain analyze --1786
select *
from (
	select *, first_value(payment_date) over (partition by customer_id order by payment_date desc)
	from "dvd-rental".payment) t
where payment_date = first_value

--использовать last_value не желательно!

--получение послежней в кэше памяти записи, а она была в сортировке => не работает не так как мы хотим
select distinct customer_id, payment_date,
	last_value(payment_date) over (partition by customer_id order by payment_date),
	last_value(amount) over (partition by customer_id order by payment_date),
	last_value(rental_id) over (partition by customer_id order by payment_date)
from "dvd-rental".payment
order by 1

select customer_id, payment_date, amount, rental_id
from "dvd-rental".payment
order by customer_id

--last_value с продумыванием того, что последнее сидело в кэше = работает, но сложно
select *
from (
	select *, last_value(payment_date) over (partition by customer_id)
	from (
		select *
		from "dvd-rental".payment
		order by customer_id, payment_date) p) t
where payment_date = last_value

--ломка окна и передача всех значений
select *
from (
	select *, last_value(payment_date) over (partition by customer_id order by payment_date
		rows between unbounded preceding and unbounded following)
	from "dvd-rental".payment) t
where payment_date = last_value

--полчение по 10 платежу пользователя
explain analyze --1786 / 13.7
select *
from (
	select *, nth_value(payment_date, 10) over (partition by customer_id order by payment_date)
	from "dvd-rental".payment) t
where payment_date = nth_value

--полчение по 10 платежу пользователя
explain analyze --1786 / 12
select *
from (
	select *, row_number() over (partition by customer_id order by payment_date)
	from "dvd-rental".payment) t
where row_number = 10

--алиасы окон

select c.last_name, f.title, amount, date_trunc('month', p.payment_date),
	avg(p.amount) over w_1,
	count(p.amount) over w_1,
	sum(p.amount) over w_1,
	min(p.amount) over w_1,
	max(p.amount) over w_1,
	avg(p.amount) over w_2,
	count(p.amount) over w_2,
	sum(p.amount) over w_3,
	min(p.amount) over w_3,
	max(p.amount) over w_3
from "dvd-rental".customer c
join "dvd-rental".payment p on p.customer_id = c.customer_id
join "dvd-rental".rental r on p.rental_id = r.rental_id
join "dvd-rental".inventory i on i.inventory_id = r.rental_id
join "dvd-rental".film f on f.film_id = i.film_id
--описание псевдонимов окон
window 
	w_1 as (partition by c.customer_id), 
	w_2 as (partition by c.customer_id order by p.payment_date),
	w_3 as (partition by c.customer_id, date_trunc('month', p.payment_date))
order by 1
	
============= общие табличные выражения =============

2.  При помощи CTE выведите таблицу со следующим содержанием:
Название фильма продолжительностью более 3 часов и к какой категории относится фильм
* Создайте CTE:
 - Используйте таблицу film
 - отфильтруйте данные по длительности
 * напишите запрос к полученной CTE:
 - соедините с film_category
 - соедините с category

with 
	cte1 as (
		select *
		from "dvd-rental".film 
		where length > 180),
	cte2 as (
		select *
		from cte1 
		join "dvd-rental".film_category fc on fc.film_id = cte1.film_id)
select cte2.title, c."name"
from cte2
join "dvd-rental".category c on c.category_id = cte2.category_id

with cte as (
	select *, row_number() over (partition by customer_id order by payment_date)
	from "dvd-rental".payment
	where customer_id < 3)
select c1.customer_id, c2.customer_id, c1.amount - c2.amount
from cte c1
join cte c2 on c1.row_number = c2.row_number

select 
from (
	select *, row_number() over (partition by customer_id order by payment_date)
	from "dvd-rental".payment
	where customer_id < 3) t 
join ( 
	select *, row_number() over (partition by customer_id order by payment_date)
	from "dvd-rental".payment
	where customer_id < 3) t2 on t.row_number = t2.row_number

	
create table b (
	id int,
	val int)
	
with c as (
	select customer_id, amount
	from payment)
insert into b 
select * 
from c

drop table b

2.1. Выведите фильмы, с категорией начинающейся с буквы "C"
* Создайте CTE:
 - Используйте таблицу category
 - Отфильтруйте строки с помощью оператора like 
* Соедините полученное табличное выражение с таблицей film_category
* Соедините с таблицей film
* Выведите информацию о фильмах:
title, category."name"

select version() --версия postgre

explain analyze --91.33
with c1 as (
	with c2 as (
		select *
		from "dvd-rental".category 
		where left(name, 1) = 'C')
	select *
	from c2
	join "dvd-rental".film_category fc on fc.category_id = c2.category_id)
select f.title, c1.name
from c1
join "dvd-rental".film f on f.film_id = c1.film_id

============= общие табличные выражения (рекурсивные) =============
 
 3.Вычислите факториал
 + Создайте CTE
 * стартовая часть рекурсии (т.н. "anchor") должна позволять вычислять начальное значение
 *  рекурсивная часть опираться на данные с предыдущей итерации и иметь условие остановки
 + Напишите запрос к CTE

 --в рекурсии нельзя использовать агрегатные ф-у => использовать подзапросы
 
with recursive r as (
	--стартовая часть
	select 1 as i, 1 as factorial
	union 
	--рекурсивная часть
	select i + 1 as i, factorial * (i + 1) as factorial
	from r
	where i < 10)
select *
from r

with recursive r as (
	--стартовая часть
	select *, 1 as level
	from hr."structure" s
	where unit_id = 95
	union 
	--рекурсивная часть
	select s.*, level + 1 as level
	from r 
	join hr."structure" s on r.parent_id = s.unit_id)
select *
from r

with recursive r as (
	--стартовая часть
	select *, 1 as level
	from "structure" s
	where unit_id = 18
	union 
	--рекурсивная часть
	select s.*, level + 1 as level
	from r 
	join "structure" s on s.parent_id = r.unit_id)
select count(*)
from r
join "position" p on p.unit_id = r.unit_id 
join employee e on e.pos_id = p.pos_id

--Работа с рядами.

explain analyse --3.57
with recursive r as (
	--стартовая часть
	select '01.01.2022'::date x
	union 
	--рекурсивная часть
	select x + 1 as x
	from r
	where x < '31.12.2022')
select *
from r

--explain analyse --12.51
select x::date
from generate_series('01.01.2022'::date, '31.12.2022'::date, interval '1 day') x

--explain analyse --3.57
with recursive r as (
	--стартовая часть
	select 1 x
	union 
	--рекурсивная часть
	select x + 1 as x
	from r
	where x < 100)
select *
from r

explain analyse --1
select x
from generate_series(1, 100, 1) x

select date_trunc('month', payment_date), sum (amount),
	sum (amount) - lag(sum (amount)) over (order by date_trunc('month', payment_date))
from payment 
group by 1

--explain analyze --5027 / 11.3
with recursive r as (
	--стартовая часть
	select min(date_trunc('month', payment_date)) x from payment 
	union 
	--рекурсивная часть
	select x + interval '1 month' as x
	from r
	where x < (select max(date_trunc('month', payment_date)) from payment ))
select 
	x, 
	coalesce(t.sum, 0), --замена null на 0
	coalesce(coalesce(t.sum, 0) - lag(coalesce(t.sum, 0), 1, 0.) over (order by x), 0)
from r
left join (
	select date_trunc('month', payment_date), sum (amount)
	from payment 
	group by 1) t on t.date_trunc = r.x
order by x

--explain analyze --4937 / 11.2
select 
	x, 
	coalesce(t.sum, 0), 
	coalesce(coalesce(t.sum, 0) - lag(coalesce(t.sum, 0), 3, 0.) over (order by x), 0)
from generate_series((select min(date_trunc('month', payment_date)) x from payment),
	(select max(date_trunc('month', payment_date)) from payment ), interval '1 month') x
left join (
	select date_trunc('month', payment_date), sum(amount)
	from payment 
	group by 1) t on t.date_trunc = x
order by x


create table b (
	val1 int[],  --массив int
	val1 numeric[] check(array_length(val1, 1) > 1), )  --массив int хотя бы с 1им элементом

lag(значение, шаг, значение по умолчанию) over ()
lead() over ()

select payment_date, date_trunc('QUARTER', payment_date)
from payment 

select payment_date, date_part('isodow', payment_date)
from payment 

--zoom z-46-2

timestamp - timestamp = interval
date - date = integer
epoch /60/60/24

Задание 1. Создайте новую таблицу film_new со следующими полями:
· film_name — название фильма — тип данных varchar(255) и ограничение not null;
· film_year — год выпуска фильма — тип данных integer, условие, что значение должно быть больше 0;
· film_rental_rate — стоимость аренды фильма — тип данных numeric(4,2), значение по умолчанию 0.99;
· film_duration — длительность фильма в минутах — тип данных integer, ограничение not null и условие, 
что значение должно быть больше 0.
Если работаете в облачной базе, то перед названием таблицы задайте наименование вашей схемы.

create table film_new (
	film_id serial primary key,
	film_name (255) not null,
	film_year integer check(film_year > 0), 
	film_rental_rate numeric(4,2) default 0.99,
	film_duration integer not null check(film_duration > 0))
	
drop table film_new

Задание 2. Заполните таблицу film_new данными с помощью SQL-запроса, где колонкам соответствуют массивы данных:
· film_name — array[The Shawshank Redemption, The Green Mile, Back to the Future, Forrest Gump, Schindler’s List];
· film_year — array[1994, 1999, 1985, 1994, 1993];
· film_rental_rate — array[2.99, 0.99, 1.99, 2.99, 3.99];
· film_duration — array[142, 189, 116, 142, 195].

insert into film_new (film_name, film_year, film_rental_rate, film_duration)
select *
from unnest(
	array['The Shawshank Redemption', 'The Green Mile', 'Back to the Future', 'Forrest Gump', 'Schindler’s List'],
	array[1994, 1999, 1985, 1994, 1993],
	array[2.99, 0.99, 1.99, 2.99, 3.99],
	array[142, 189, 116, 142, 195])


select unnest(array)

from unnest(array1, array2 ... arrayN)

select * from film_new

Задание 3. Обновите стоимость аренды фильмов в таблице film_new с учётом информации, 
что стоимость аренды всех фильмов поднялась на 1.41.

update film_new
set film_rental_rate = film_rental_rate + 1.41

Задание 4. Фильм с названием Back to the Future был снят с аренды, удалите строку с этим фильмом из таблицы film_new.

delete from film_new
where film_id = 3

Задание 5. Добавьте в таблицу film_new запись о любом другом новом фильме.

insert into film_new (film_name, film_year, film_duration)
values('a', 2000, 3)

Задание 6. Напишите SQL-запрос, который выведет все колонки из таблицы film_new, 
а также новую вычисляемую колонку «длительность фильма в часах», округлённую до десятых.

alter table - грубая ошибка

select *, round(film_duration / 60., 1) --при делении на integer дробная часть будет автоматически отбрасываться. Надо делить на float
from film_new

Задание 7. Удалите таблицу film_new.

drop table film_new

Задание 1. С помощью оконной функции выведите для каждого сотрудника сумму продаж за август 2005 года с
нарастающим итогом по каждому сотруднику и по каждой дате продажи (без учёта времени) с сортировкой по дате.
Ожидаемый результат запроса: letsdocode.ru...in/5-5.png

explain analyze --366 / 4.5
select staff_id, payment_date::date, sum(amount), sum(sum(amount)) over (partition by staff_id order by payment_date::date)
from payment 
where date_trunc('month', payment_date) = '01.08.2005'
--where date_part('month', payment_date) = 8 and date_part('year', payment_date) = 2005
--where payment_date::date between '01.08.2005' and '31.08.2005'
group by 1, 2

Задание 2. 20 августа 2005 года в магазинах проходила акция: покупатель каждого сотого платежа получал 
дополнительную скидку на следующую аренду. С помощью оконной функции выведите всех покупателей, которые в 
день проведения акции получили скидку.
Ожидаемый результат запроса: letsdocode.ru...in/5-6.png

explain analyze

select *
from (
	select customer_id, row_number() over (order by payment_date)
	from payment 
	where payment_date::date = '20.08.2005') t
--where row_number::text ilike '%00' - плохо
--where row_number % 100 = 0
where mod(row_number, 100) = 0

select 100/3
select div(10, 4)
select 10 / 4

from 
on 
join 
where 
group by 
having 
over 
select 

select customer_id, sum(amount) as sa
from payment 
group by customer_id
having sum(amount) > 100

Задание 3. Для каждой страны определите и выведите одним SQL-запросом покупателей, которые попадают под условия:
· покупатель, арендовавший наибольшее количество фильмов;
· покупатель, арендовавший фильмов на самую большую сумму;
· покупатель, который последним арендовал фильм.
Ожидаемый результат запроса: letsdocode.ru...in/5-7.png

explain analyze --8161
with c1 as (
	select c.customer_id, c2.country_id, sum(p.amount), count(i.film_id), max(r.rental_date), concat(c.last_name, ' ', c.first_name)
	from payment p
	join rental r on p.rental_id = r.rental_id
	join inventory i on i.inventory_id = r.inventory_id
	join customer c on c.customer_id = p.customer_id
	join address a on a.address_id = c.address_id
	join city c2 on c2.city_id = a.city_id
	group by 1, 2),
c2 as (
	select *,
		row_number() over (partition by country_id order by sum desc) rs,
		row_number() over (partition by country_id order by count desc) rc,
		row_number() over (partition by country_id order by max desc) rm
	from c1)
select c.country, x.concat, y.concat, z.concat
from country c
left join c2 x on c.country_id = x.country_id and x.rs = 1
left join c2 y on c.country_id = y.country_id and y.rc = 1
left join c2 z on c.country_id = z.country_id and z.rm = 1

explain analyze --5533
with c1 as (
	select c.customer_id, c2.country_id, concat(c.last_name, ' ', c.first_name),
		sum(p.amount), count(i.film_id), max(r.rental_date),
		max(sum(p.amount)) over (partition by country_id) ms,
		max(count(i.film_id)) over (partition by country_id) mc,
		max( max(r.rental_date)) over (partition by country_id) mm
	from payment p
	join rental r on p.rental_id = r.rental_id
	join inventory i on i.inventory_id = r.inventory_id
	join customer c on c.customer_id = p.customer_id
	join address a on a.address_id = c.address_id
	join city c2 on c2.city_id = a.city_id
	group by 1, 2)
select c.country, string_agg(distinct x.concat, ', '), string_agg(distinct y.concat, ', '), string_agg(distinct z.concat, ', ')
from country c
left join c1 x on x.country_id = c.country_id and x.sum = x.ms
left join c1 y on y.country_id = c.country_id and y.count = x.mc
left join c1 z on z.country_id = c.country_id and z.max = x.mm
group by c.country_id

explain analyze --4819
with c1 as (
	select c.customer_id, c2.country_id, concat(c.last_name, ' ', c.first_name),
		sum(p.amount), count(i.film_id), max(r.rental_date),
		max(sum(p.amount)) over (partition by country_id) ms,
		max(count(i.film_id)) over (partition by country_id) mc,
		max( max(r.rental_date)) over (partition by country_id) mm
	from payment p
	join rental r on p.rental_id = r.rental_id
	join inventory i on i.inventory_id = r.inventory_id
	join customer c on c.customer_id = p.customer_id
	join address a on a.address_id = c.address_id
	join city c2 on c2.city_id = a.city_id
	group by 1, 2),
c2 as (
	select *,	
		case when sum = ms then concat end cs,
		case when count = mc then concat end cc,
		case when max = mm then concat end cm
	from c1)
select c.country, string_agg(distinct c2.cs, ', '), string_agg(distinct c2.cc, ', '), string_agg(distinct c2.cm, ', ')
from country c
left join c2 on c2.country_id = c.country_id 
group by c.country_id

explain analyze --1570
with c1 as (
	select c.customer_id, c2.country_id, sum, count, max, concat(c.last_name, ' ', c.first_name)
	from (
		select customer_id, sum(amount)
		from payment 
		group by 1) p
	join ( 
		select r.customer_id, count(i.film_id), max(r.rental_date)
		from rental r
		join inventory i on i.inventory_id = r.inventory_id
		group by 1) r on p.customer_id = r.customer_id
	join customer c on c.customer_id = p.customer_id
	join address a on a.address_id = c.address_id
	join city c2 on c2.city_id = a.city_id),
c2 as (
	select *,
		rank() over (partition by country_id order by sum desc) rs,
		rank() over (partition by country_id order by count desc) rc,
		rank() over (partition by country_id order by max desc) rm
	from c1
)
select c.country, string_agg(distinct x.concat, ', '), string_agg(distinct y.concat, ', '), string_agg(distinct z.concat, ', ')
from country c
left join c2 x on x.country_id = c.country_id and x.rs = 1
left join c2 y on y.country_id = c.country_id and y.rc = 1
left join c2 z on z.country_id = c.country_id and z.rm = 1
group by c.country_id

explain analyze --1402
with c1 as (
	select p.customer_id, sum(amount), count(i.film_id), max(r.rental_date)
	from payment p
	join rental r on r.rental_id = p.rental_id
	join inventory i on i.inventory_id = r.inventory_id
	group by 1),
c2 as (
	select *, concat(c.last_name, ' ', c.first_name),
		rank() over (partition by country_id order by sum desc) rs,
		rank() over (partition by country_id order by count desc) rc,
		rank() over (partition by country_id order by max desc) rm
	from c1
	join customer c on c.customer_id = c1.customer_id
	join address a on a.address_id = c.address_id
	join city c2 on c2.city_id = a.city_id)
select c.country, string_agg(distinct x.concat, ', '), string_agg(distinct y.concat, ', '), string_agg(distinct z.concat, ', ')
from country c
left join c2 x on x.country_id = c.country_id and x.rs = 1
left join c2 y on y.country_id = c.country_id and y.rc = 1
left join c2 z on z.country_id = c.country_id and z.rm = 1
group by c.country_id

select 8100./1400

https://letsdocode.ru/sql-main/info

Скринкаст восстановления дампа, если ДБивер виснет

--m6-utf8

--=============== МОДУЛЬ 6. POSTGRESQL =======================================
--= ПОМНИТЕ, ЧТО НЕОБХОДИМО УСТАНОВИТЬ ВЕРНОЕ СОЕДИНЕНИЕ И ВЫБРАТЬ СХЕМУ PUBLIC===========
SET search_path TO public;

--======== ОСНОВНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Напишите SQL-запрос, который выводит всю информацию о фильмах 
--со специальным атрибутом "Behind the Scenes".





--ЗАДАНИЕ №2
--Напишите еще 2 варианта поиска фильмов с атрибутом "Behind the Scenes",
--используя другие функции или операторы языка SQL для поиска значения в массиве.





--ЗАДАНИЕ №3
--Для каждого покупателя посчитайте сколько он брал в аренду фильмов 
--со специальным атрибутом "Behind the Scenes.

--Обязательное условие для выполнения задания: используйте запрос из задания 1, 
--помещенный в CTE. CTE необходимо использовать для решения задания.





--ЗАДАНИЕ №4
--Для каждого покупателя посчитайте сколько он брал в аренду фильмов
-- со специальным атрибутом "Behind the Scenes".

--Обязательное условие для выполнения задания: используйте запрос из задания 1,
--помещенный в подзапрос, который необходимо использовать для решения задания.





--ЗАДАНИЕ №5
--Создайте материализованное представление с запросом из предыдущего задания
--и напишите запрос для обновления материализованного представления





--ЗАДАНИЕ №6
--С помощью explain analyze проведите анализ стоимости выполнения запросов из предыдущих заданий и ответьте на вопросы:
--1. с каким оператором или функцией языка SQL, используемыми при выполнении домашнего задания: 
--поиск значения в массиве затрачивает меньше ресурсов системы;
--2. какой вариант вычислений затрачивает меньше ресурсов системы: 
--с использованием CTE или с использованием подзапроса.





--======== ДОПОЛНИТЕЛЬНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Выполняйте это задание в форме ответа на сайте Нетологии

--ЗАДАНИЕ №2
--Используя оконную функцию выведите для каждого сотрудника
--сведения о самой первой продаже этого сотрудника.





--ЗАДАНИЕ №3
--Для каждого магазина определите и выведите одним SQL-запросом следующие аналитические показатели:
-- 1. день, в который арендовали больше всего фильмов (день в формате год-месяц-день)
-- 2. количество фильмов взятых в аренду в этот день
-- 3. день, в который продали фильмов на наименьшую сумму (день в формате год-месяц-день)
-- 4. сумму продажи в этот день


--p6-46

============= представления =============

4. Создайте view с колонками клиент (ФИО; email) и title фильма, который он брал в прокат последним
+ Создайте представление:
* Создайте CTE, 
- возвращает строки из таблицы rental, 
- дополнено результатом row_number() в окне по customer_id
- упорядочено в этом окне по rental_date по убыванию (desc)
* Соеднините customer и полученную cte 
* соедините с inventory
* соедините с film
* отфильтруйте по row_number = 1

create view task_1 as 
	--explain analyze --2115
	select concat(c.last_name, ' ', c.first_name), c.email, f.title
	from (
		select *, row_number() over (partition by customer_id order by rental_date desc)
		from rental) t 
	join customer c on c.customer_id = t.customer_id
	join inventory i on i.inventory_id = t.inventory_id
	join film f on f.film_id = i.film_id
	where t.row_number = 1
	
select t.*, p.amount
from task_1 t --обращение к представлению => перерасчет представления
join customer c on t.concat = concat(c.last_name, ' ', c.first_name)
join payment p on p.customer_id = c.customer_id

explain analyze --2115
select *
from task_1 

4.1. Создайте представление с 3-мя полями: название фильма, имя актера и количество фильмов, в которых он снимался
+ Создайте представление:
* Используйте таблицу film
* Соедините с film_actor
* Соедините с actor
* count - агрегатная функция подсчета значений
* Задайте окно с использованием предложений over и partition by

create view task_2 as 
	--explain analyze --645


	select f.title, concat(a.last_name, ' ', a.first_name), count(*) over (partition by a.actor_id)
	from film f
	join film_actor fa on f.film_id = fa.film_id
	join actor a on a.actor_id = fa.actor_id
	
explain analyze --700.57
select *
from task_2 

create view task_3 as
	select s.store_id, payment_date::date, sum(amount)
	from payment p
	join staff s on s.staff_id = p.staff_id
	group by 1, 2
	order by 1, 2
	
select * 
from task_3 t
join staff s on s.store_id = t.store_id

select s.store_id, payment_date::date, sum(amount)
from payment p
join staff s on s.staff_id = p.staff_id
group by 1, 2
order by 1, 2

select * from payment p

============= материализованные представления =============

5. Создайте материализованное представление с колонками клиент (ФИО; email) и title фильма, 
который он брал в прокат последним
Иницилизируйте наполнение и напишите запрос к представлению.
+ Создайте материализованное представление без наполнения (with NO DATA):
* Создайте CTE, 
- возвращает строки из таблицы rental, 
- дополнено результатом row_number() в окне по customer_id
- упорядочено в этом окне по rental_date по убыванию (desc)
* Соеднините customer и полученную cte 
* соедините с inventory
* соедините с film
* отфильтруйте по row_number = 1
+ Обновите представление
+ Выберите данные --2148

create materialized view task_4 as 
	--explain analyze --2115 / 14.4
	select concat(c.last_name, ' ', c.first_name), c.email, f.title
	from (
		select *, row_number() over (partition by customer_id order by rental_date desc)
		from rental) t 
	join customer c on c.customer_id = t.customer_id
	join inventory i on i.inventory_id = t.inventory_id
	join film f on f.film_id = i.film_id
	where t.row_number = 1
with no data --без сохранения (материализации) данных на жестком диске 

select * from task_4 --ошибка, так как данных нет на жестком диске

refresh materialized view task_4 --19:30 запись данных на жесткий диск

explain analyze --11.1 / .037
select * from task_4

select 14.4 / .037

select * from task_4 --актуальность на 19:30 

refresh materialized view task_4 --19:40

5.1. Содайте наполенное материализованное представление, содержащее:
список категорий фильмов, средняя продолжительность аренды которых более 5 дней
+ Создайте материализованное представление с наполнением (with DATA)
* Используйте таблицу film
* Соедините с таблицей film_category
* Соедините с таблицей category
* Сгруппируйте полученную таблицу по category.name
* Для каждой группы посчитайте средню продолжительность аренды фильмов
* Воспользуйтесь фильтрацией групп, для выбора категории со средней продолжительностью > 5 дней
 + Выберите данные

create materialized view task_5 as 
	select c."name"
	from film f
	join film_category fc on f.film_id = fc.film_id
	join category c on c.category_id = fc.category_id
	group by c.category_id
	having avg(f.rental_duration) > 5
--with data
	
select * from task_5

explain analyze --15.98 / 0.105
select * 
from task_4
where left(concat, 1) = 'T'

create index first_letter_task_4_idx on task_4 (left(concat, 1)) --создание индекса на первую букву пользователя

explain analyze --10.33 / 0.026
select * 
from task_4
where left(concat, 1) = 'T'

select 14 / 0.026

explain analyze --1978 / 14
select concat(c.last_name, ' ', c.first_name), c.email, f.title
from (
	select *, row_number() over (partition by customer_id order by rental_date desc)
	from rental) t 
join customer c on c.customer_id = t.customer_id
join inventory i on i.inventory_id = t.inventory_id
join film f on f.film_id = i.film_id
where t.row_number = 1 and left(concat(c.last_name, ' ', c.first_name), 1) = 'T'

============ Индексы ===========

CREATE [ UNIQUE ] INDEX [ CONCURRENTLY ] [ [ IF NOT EXISTS ] name ] ON [ ONLY ] table_name [ USING method ]
    ( { column_name | ( expression ) } [ COLLATE collation ] [ opclass [ ( opclass_parameter = value [, ... ] ) ] ] [ ASC | DESC ] [ NULLS { FIRST | LAST } ] [, ...] )
    [ INCLUDE ( column_name [, ...] ) ]
    [ WITH ( storage_parameter [= value] [, ... ] ) ]
    [ TABLESPACE tablespace_name ]
    [ WHERE predicate ]
    
--индексы ускоряют посик в таблоицк ценой места на жестком диске и временем работы insert, update, delete

alter table film drop constraint film_pkey cascade  --удаление первичного ключа и индексов соответственно

0 индексов - 472кб
    
explain analyze
select *
from film 

Seq Scan - полное сканирование таблицы

explain analyze --67.5 / .126
select *
from film 
where film_id = 371

alter table film add constraint film_pkey primary key (film_id)

1 индекс - 512кб

explain analyze --8.29 / .013
select *
from film 
where film_id = 371

Index Scan using film_pkey  - индексное сканирование с указанием индекса

btree - > < = between null (работает со всеми условиями)
hash = (работает только при сравнеии с равенством)
gist - сложные типы + полнотекстовый поиск
gin - сложные типы, массивы геоданные
+ интерфейсные

btree 
1-1000
1-500 501-1000
1-250 251-500 501-750 751-1000
1-125 126-250 251-375 376-500 500-625 ...

create index release_year_idx on film (release_year)

explain analyze
select *
from film 
where release_year = 2006

create index ry_desc_title_idx on film (release_year, description, title) --индекс на 3 столбца сразу

explain analyze
select *
from film 
where title = 'AFFAIR PREJUDICE' and description = 'A Fanciful Documentary of a Frisbee And a Lumberjack who must Chase a Monkey in A Shark Tank'

3 индекса - 688кб

create index ci_idx on payment (customer_id, amount)

explain analyze
select *
from payment 
where customer_id = 1

drop index idx_fk_customer_id 

explain analyze --8.29 / 0.13
select *
from film 
where film_id < 371

create index film_id_hash_idx on film using hash (film_id) -- добавляем доп индекс для равенства

explain analyze --8.02 / 0.11
select *
from film 
where film_id = 630

Index Scan using film_pkey on film 

Index Scan using film_id_hash_idx on film

3 таблицы с индексами + основная таблица = место на жестком диске

explain analyze
select *
from payment 
where payment_date::date = '2005-08-22'

create index payment_date_date_idx on payment (cast(payment_date as date)) --:: не работает!
--если в табюлице тип колонки н-р timestamp а поиск по индексу данной колонки мы будем делать по типу date, то индекс работать не будет!!!

explain analyze
select *
from payment 
where payment_date::date = '2005-08-22'

select 16049 / 118

create index payment_date_year_idx on payment (date_part('year', payment_date))

drop index payment_date_year_idx

explain analyze
select *
from payment 
where date_part('year', payment_date) = 2006

explain analyze
select *
from payment 
where date_part('year', payment_date) = 2005

============ explain ===========

Ссылка на сервис по анализу плана запроса 
https://explain.depesz.com/ -- открывать через ВПН
https://tatiyants.com/pev/
https://habr.com/ru/post/203320/

--explain без параметров выводит план выполнения запроса справа-налево и снизу-вверх ПО ОТСТУПАМ!!!
EXPLAIN [ ( параметр [, ...] ) ] оператор
EXPLAIN [ ANALYZE ] [ VERBOSE ] оператор

Здесь допускается параметр:

    ANALYZE [ boolean ]
    VERBOSE [ boolean ]
    COSTS [ boolean ]
    BUFFERS [ boolean ]
    TIMING [ boolean ]
    FORMAT { TEXT | XML | JSON | YAML }

explain 
select concat(c.last_name, ' ', c.first_name), c.email, f.title
from (
	select *, row_number() over (partition by customer_id order by rental_date desc)
	from rental) t 
join customer c on c.customer_id = t.customer_id
join inventory i on i.inventory_id = t.inventory_id
join film f on f.film_id = i.film_id
where t.row_number = 1

explain analyze
select concat(c.last_name, ' ', c.first_name), c.email, f.title
from (
	select *, row_number() over (partition by customer_id order by rental_date desc)
	from rental) t 
join customer c on c.customer_id = t.customer_id
join inventory i on i.inventory_id = t.inventory_id
join film f on f.film_id = i.film_id
where t.row_number = 1

explain (format json, analyze)  --вывод explain в форматк json для https://tatiyants.com/pev/ для предсталения запроса в человеческом формате
select concat(c.last_name, ' ', c.first_name), c.email, f.title
from (
	select *, row_number() over (partition by customer_id order by rental_date desc)
	from rental) t 
join customer c on c.customer_id = t.customer_id
join inventory i on i.inventory_id = t.inventory_id
join film f on f.film_id = i.film_id
where t.row_number = 1

explain analyze
select *
from payment p
join rental r on p.customer_id = r.customer_id

--данные и стоимость запроса нелинейны!
1000    100
100000  300
1000000 600
1000001 8000

2666  10-10-10-10 - 100 000
3200 12-12-12-12 - 170 000

100  	500000
500000 	1
1500 	35

======================== json ========================
Создайте таблицу orders

CREATE TABLE orders (
     ID serial PRIMARY KEY,
     info json NOT NULL
);

INSERT INTO orders (info)
VALUES
 ('{"items": {"product": "Beer","qty": 6,"a":345}, "customer": "John Doe"}'),
 ('{ "customer": "Lily Bush", "items": {"product": "Diaper","qty": 24}}'),
 ('{ "customer": "Josh William", "items": {"product": "Toy Car","qty": 1}}'),
 ('{ "customer": "Mary Clark", "items": {"product": "Toy Train","qty": 2}}');
 
select * from orders

INSERT INTO orders (info)
VALUES
 ('{ "a": { "a": { "a": { "a": { "a": { "c": "b"}}}}}}')


|{название_товара: quantity, product_id: quantity, product_id: quantity}|общая сумма заказа|

6. Выведите общее количество заказов:
* CAST ( data AS type) преобразование типов
* SUM - агрегатная функция суммы
* -> возвращает JSON
*->> возвращает текст

select pg_typeof(info), info
from orders

select pg_typeof(info->'items'), info->'items'
from orders

select pg_typeof(info->'items'->'qty'), info->'items'->'qty'
from orders

select pg_typeof(info->'items'->>'qty'), info->'items'->>'qty'
from orders

select sum((info->'items'->>'qty')::int) --sum не умеет работать с json
from orders

6*  Выведите среднее количество заказов, продуктов начинающихся на "Toy"

select avg((info->'items'->>'qty')::int)
from orders
where info->'items'->>'product' ilike 'toy%'

select json_object_keys(info->'items'), json_object_keys(info)
from orders

======================== array ========================
7. Выведите сколько раз встречается специальный атрибут (special_features) у
фильма -- сколько элементов содержит атрибут special_features
* array_length(anyarray, int) - возвращает длину указанной размерности массива

wish_list [1,3456,234,4567,678,234]

'1,3456,234,4567,678,234'

create table c (
	id serial primary key,
	val int[])
	
int[]
date[]
varchar[] 
numeric[] 
text['01.01.2022', '100', 'asdfadsf']

insert into c (val)
values('{5}'::int[]) --вставка в массив

select val[1] --индекс
from c

update c 
set val[-10] = 9 --расширение массива

select *
from c

{[-10:1]={9,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,5}}

select val[-10:-5]  --срез (диаппазон)
from c

select array_lower(val, 1), array_upper(val, 1) --первый и посдедний эл-ты (второй аргумент - мерность простарнства)
from c

select array_length(val, 1) --длина массива
from c

select array_length('{{1,2,3},{1,2,3},{1,2,3},{1,2,3},{1,2,3},{1,2,3}}'::text[], 1) --6 = мерность пространства

select array_length('{{1,2,3},{1,2,3},{1,2,3},{1,2,3},{1,2,3},{1,2,3}}'::text[], 2) --3

select cardinality('{{1,2,3},{1,2,3},{1,2,3},{1,2,3},{1,2,3},{1,2,3}}'::text[]) --18 = всего-всего эдементов

7* Выведите все фильмы содержащие специальные атрибуты: 'Trailers'
* Используйте операторы:
@> - содержит
<@ - содержится в
*  ARRAY[элементы] - для описания массива

https://postgrespro.ru/docs/postgresql/14/functions-subquery
https://postgrespro.ru/docs/postgrespro/14/functions-array

select title, pg_typeof(special_features)
from film f

-- ПЛОХАЯ ПРАКТИКА --
select title, special_features--, array_upper(special_features, 1)
from film f
where special_features[1] = 'Trailers' or special_features[2] = 'Trailers' or 
	special_features[3] = 'Trailers' or special_features[4] = 'Trailers'
	
select title, special_features--, array_upper(special_features, 1)
from film f
where special_features::text ilike '%Trailers%'

-- ЧТО-ТО СРЕДНЕЕ ПРАКТИКА --
select film_id, title, array_agg(unnest)
from (
	select film_id, title, unnest(special_features) --разбивка массива по строкам
	from film f) t
where unnest = 'Trailers' or unnest = 'Behind the Scenes'
group by 1, 2

select title, special_features
from film f
where 'Trailers' in (select unnest(special_features))

-- ХОРОШАЯ ПРАКТИКА --
select title, special_features
from film f
where special_features && array['Trailers', 'Behind the Scenes'] --any in хотя бы один элемент слева должен быть равен хотя бы одному элементу справа

select title, special_features
from film f
where special_features @> array['Trailers', 'Behind the Scenes'] --все слева должно быть справа

select title, special_features
from film f
where array['Trailers', 'Behind the Scenes'] <@ special_features --все справа должно быть слева

select title, special_features
from film f
where 'Trailers' = any(special_features) --some

select title, special_features
from film f
where 'Trailers' = all(special_features) --один или все ждементы в массивие равны 'Trailers'

select title, special_features, array_position(special_features, 'Trailers') --индекс элемента первого входления
from film f
where array_position(special_features, 'Trailers') is not null

select title, special_features, array_positions(special_features, 'Trailers')
from film f
where array_length(array_positions(special_features, 'Trailers'), 1) > 0

--работаем в схеме aa

==========планировка==========

create materialized view test_mat as
	select s.store_id, payment_date::date, sum(amount), now()
	from public.payment p
	join public.staff s on s.staff_id = p.staff_id
	group by 1, 2
	order by 1, 2
	
select * from test_mat -- 2022-11-07 22:03:24.663951+03

refresh materialized view test_mat 

select * from test_mat -- 2022-11-07 22:03:42.485571+03

create table mat_view_audit (
	mat_view_name varchar(64) not null, --64 потому что нельзя длинее делать название чем 4 символа
	refresh_user varchar(64) default current_user,
	refresh_time timestamp default now())
	
insert into mat_view_audit (mat_view_name) values ('test_mat')

select * from mat_view_audit --2022-11-07 22:17:30.146651

select * from test_mat -- 2022-11-07 22:17:30.128317+03

SET PGPASSWORD=123 --обязательно CAPSLOCK С ПРОБЕЛОМ И БЕЗ КАВЫЧЕК
"c:\program files\postgresql\14\bin\psql" --путь расположения сервера на компе
-h localhost --host
-p 5432  --port
-U postgres --user
-d postgres --db
-c "set search_path to aa;" --cmd в двойных кавычках и ; 
-c "refresh materialized view test_mat;" --cmd в двойных кавычках и ; 
-c "insert into mat_view_audit (mat_view_name) values ('test_mat');" --cmd в двойных кавычках и ; 
--ОБЯЗАТЕЛЬНО ВЫШЕПРЕДСТПАВЛЕННОЕ СВЕСТИ В ОДНУ СТРОЧКУ

--далее сохраняем в исполнительный файл и делаем запланированное дейсвие на этот исполнительный файл

--p7-46--практика

select *
from person 
where date_part('year', age(dob)) > 65

select sum(e.salary)
from (
	select emp_id, max(effective_from)
	from employee_salary 
	group by emp_id) t 
join employee_salary e on e.emp_id = t.emp_id and e.effective_from = t.max

select count(*)
from "position" p
left join employee e on e.pos_id = p.pos_id
where e.emp_id is null

select e.emp_id, e.salary, string_agg(g.grade::text, ', ')
from (
	select emp_id, max(effective_from)
	from employee_salary 
	group by emp_id) t 
join employee_salary e on e.emp_id = t.emp_id and e.effective_from = t.max
left join grade_salary g on e.salary between g.min_salary and g.max_salary
group by e.emp_id, e.salary

select project_id,
	case 
		when employees_id && array[assigned_id] then array_length(employees_id, 1) 
		else array_length(employees_id, 1) + 1
	end
from projects 

--z46-3

������� 1. �������� �� ������ SQL-������.

explain analyze
select distinct cu.first_name  || ' ' || cu.last_name as name, 
	count(ren.iid) over (partition by cu.customer_id)
from customer cu
full outer join 
	(select *, r.inventory_id as iid, inv.sf_string as sfs, r.customer_id as cid
	from rental r 
	full outer join 
		(select *, unnest(f.special_features) as sf_string
		from inventory i
		full outer join film f on f.film_id = i.film_id) as inv 
		on r.inventory_id = inv.inventory_id) as ren 
	on ren.cid = cu.customer_id 
where ren.sfs like '%Behind the Scenes%'
order by count desc

explain analyze  --620 / 5.5
select c.last_name, c.first_name, count(i.film_id)
from rental r
right join inventory i on i.inventory_id = r.inventory_id and i.film_id in 
	(select film_id
	from film 
	where special_features && array['Behind the Scenes'])
join customer c on c.customer_id = r.customer_id
group by c.customer_id

explain analyze  --188 / 14
select T.customer_id, T.count
from 
	(select c.customer_id,
	count(f.film_id) over (partition  by c.customer_id)
	from customer c 
	join  rental r on r.customer_id = c.customer_id 
	join inventory i on i.inventory_id = r.inventory_id  
	join film f on f.film_id = i.film_id 
	where array[f.special_features] && array['Behind the Scenes']
	group by c.customer_id, f.film_id) T
group by T.customer_id, T.count

explain analyze -- 183 / 8
select c.customer_id,
count(f.film_id) 
from customer c 
join  rental r on r.customer_id = c.customer_id 
join inventory i on i.inventory_id = r.inventory_id  
join film f on f.film_id = i.film_id 
where array[f.special_features] && array['Behind the Scenes']
group by c.customer_id



�������� explain analyze ����� �������.
����������� �� �������� �������, ������� ����� ����� � ������� ��.
�������� � ����� �������� �� �������� ����� (���� ��� ������ ���������� ������������ � 15�� � �������!).
�������� ���������� �������� explain analyze �� ������� ����� ����������������� �������. 
�������� ����� � explain ����� ���������� �� ������.

������� 2. ��������� ������� �������, �������� ��� ������� ���������� �������� � ������ ��� �������.
��������� ��������� �������: letsdocode.ru...in/6-5.png

select t.*, f.title
from (
	select *, row_number() over (partition by staff_id order by payment_date)
	from payment) t 
join rental r on r.rental_id = t.rental_id
join inventory i on i.inventory_id = r.inventory_id
join film f on f.film_id = i.film_id
where row_number = 1

������� 3. ��� ������� �������� ���������� � �������� ����� SQL-�������� ��������� ������������� ����������:
����, � ������� ���������� ������ ����� ������� (� ������� ���-�����-����);
���������� �������, ������ � ������ � ���� ����;
����, � ������� ������� ������� �� ���������� ����� (� ������� ���-�����-����);
����� ������� � ���� ����.
��������� ��������� �������: letsdocode.ru...in/6-6.png

select *
from (
	select *
	from (
		select i.store_id, rental_date::date, count(i.film_id), 
			max(count(i.film_id)) over (partition by i.store_id)
		from rental r
		join inventory i on i.inventory_id = r.inventory_id
		group by 1, 2) t
	where count = max) t1
join (
	select *
	from (
		select i.store_id, payment_date::date, sum(p.amount), 
			min(sum(p.amount)) over (partition by i.store_id)
		from payment p
		join rental r on r.rental_id = p.rental_id
		join inventory i on i.inventory_id = r.inventory_id
		group by 1, 2) t
	where sum = min) t2 on t1.store_id = t2.store_id

������		������
��������� 	���������
���� 		����
���������	����
���� 		���������

select *
from (
	select *
	from (
		select i.store_id, rental_date::date, count(i.film_id), 
			max(count(i.film_id)) over (partition by i.store_id)
		from rental r
		join inventory i on i.inventory_id = r.inventory_id
		group by 1, 2) t
	where count = max) t1
join (
	select *
	from (
		select s.store_id, payment_date::date, sum(p.amount), 
			min(sum(p.amount)) over (partition by s.store_id)
		from payment p
		join staff s on s.staff_id = p.staff_id
		group by 1, 2) t
	where sum = min) t2 on t1.store_id = t2.store_id

--conclusion
	
/*
1. Сколько оплатил каждый пользователь за прокат фильмов за каждый месяц
2. На какую сумму продал каждый сотрудник магазина
3. Сколько каждый пользователь взял фильмов в аренду
4. Сколько раз брали в прокат фильмы, в которых снимались актрисы с именем Julia
5. Сколько актеров снимались в фильмах, в названии которых встречается подстрока bed
6. Вывести пользователей, у которых указано два адреса
7. Сформировать массив из категорий фильмов и для каждого фильма вывести индекс массива соответствующей категории
8. Вывести массив с идентификаторами пользователей в фамилиях которых есть подстрока 'ah'
9. Вывести фильмы, у которых в названии третья буква 'b'
10. Найти последнюю запись по пользователю в таблице аренда без учета last_update
11. Вывести ФИО пользователя и название третьего фильма, который он брал в аренду.
12. Вывести пользователей, которые брали один и тот же фильм больше одного раза.
13. Какой из месяцев оказался наиболее доходным?
14. Одним запросом ответить на два вопроса: в какой из месяцев взяли в аренду фильмов больше всего? На сколько по отношению к предыдущему месяцу было сдано в аренду больше/меньше фильмов.
15. Определите первые две категории фильмов по каждому пользователю, которые они чаще всего берут в аренду.

1. Рассчитайте совокупный доход всех магазинов на каждую дату.
2. Выведите наиболее и наименее востребованные жанры
(те, которые арендовали наибольшее/наименьшее количество раз),
число их общих продаж и сумму дохода
3. Какова средняя арендная ставка для каждого жанра?
(упорядочить по убыванию, среднее значение округлить до сотых)
4. Cоставить список из 5 самых дорогих клиентов (арендовавших фильмы с 10 по 13 июня)
формат списка:
'Имя_клиента Фамилия_клиента email address is: e-mail_клиента'
5. Сколько арендованных фильмов было возвращено в срок, до срока возврата и после, выведите максимальную разницу со сроком?
*/
	
	