-- 2024 03 03

---- Задание 1.
-- Покажите имя, месячную зарплату и премию для всех продавцов (должность SALESMAN),
-- у которых месячная зарплата (поле SAL) превосходит премию (поле COMM).
-- Отсортируйте строки по полю SAL в порядке убывания. Если
-- несколько служащих полчают одинаковую зарплату,
-- то в пределах строк с одинаковой зарплатой
-- упорядочите их по именам сотрудникв (поле ENAME).

-- 1) Подчеркнем строки, которые ПОТЕНЦИАЛЬНО, необходимо вывести

-- 2) ограничим по должности salesman

-- 3) выделим те поля, которые необходимо вывести,
-- и именно, по тексту из задания "Покажите имя, месячную зарплату и премию"

-- 4) Пишем сам запрос:
select ename, sal, comm
    from salgrade      -- одна строчка у нас выпадает, потому что sal (1250) меньше чем comm (1400)
    where sal > nvl(comm, 0) -- nvl() это функция с заменой NULL значений, в посткгресе, майскл, оракл они могут быть разными
    order by sal desc, ename
    -- сортировка по зарплате в обратном порядке, и по имени по возрастанию


-- Задание 2
-- Напечатайте список служащих, включающий их имя и оклад.
-- Если оклад ниже $1500, то замените его на сообщение "Below 1500".
-- Значение $1500 замените на "On Target".

-- 1) Выделим синим цветом тех сотрудников, зп которых ниже 1500,
-- а зеленым тех, у кого выше 1500.

-- Обратите внимание, в задание не говорится о том,
-- что нужно что-то сделать, если зп > 1500!!

-- 2) выделим поля, которые необходимо вывести
-- (включающий их имя и оклад)

select ename,
    case
        when sal < 1500 then 'Below 1500'
        when sal = 1500 then 'On Target'
        else null
    end as salary
from emp;


-- 2024 03 05

-- https://youtu.be/pCr40BjqU9o?list=PLJXRI1dijmWC_TsUe1Tr9bMyjtyvG-F6X
-- Задание 1

-- Выберите наименее оплачиваемых служащих, работающих на наждого из менеджеров.
-- Исключите из таблицы результатов все групы, в которых минимальная зарплата меньше $1000.
-- Упорядочите результаты по значению поля "Минимальная зарплата" в порядке возрастания.

-- 1) Выделяем для себя ключевые слова в тексте задания, такие как:
-- -наименее оплачиваемых
-- -работающих на менеджеров
-- -исключить из результата...менее 1000...

-- 2) Не забыть добавить сортировку по минимальной зарплате

-- Пишем сам запрос:
select mgr min(sal)
    from scott.emp
    group by mgr
    having min(sal) >= 1000
    order by 2; -- это индекс поля, в котором оно располагается через запятую


-- Задание 2

-- Сформируйте таблицу, отражающую градацию служащих по уровню их зарплаты.
-- Отобразить в результате имя сотрудника, его должность, зарплату и grade

-- Пишем сам запрос:
select ename, job, sal, grade
    from scott.emp e
        join scott.salgrade sg -- это не совсем стандартный вид джойна
            on e.sal between losal and hisal;

-- П.С. INNER JOIN является дефолтным, а не LEFT JOIN


-- 2024 03 07

-- Часть 3

-- Задание 1
-- Определите, кто из служащих в каждом из отделов был зачислен на работу последним по времени.
-- Результаты упорядочие по дате зачисления.
-- Вывести в результирующие столбцы: deptno, ename, hiredate

-- 1) Подчеркнем строки, которые, потенциально, необходимо вывести
-- 2) Выделим те поля, которые необходимо вывести
-- а именно, по тексту из задания "deptno, ename, hiredate"

-- Тут есть как минимум два варианта решения данной задачи.

-- Вариант - 1 - С подзапросами
SELECT deptno, ename, hiredate
    FROM scott.emp
    WHERE (deptno, hiredate) in
        (SELECT deptno, max(hiredate)
            FROM scott.emp
            GROUP BY deptno)
            ORDER BY hiredate DESC;

-- Вариант - 2 - С аналитическими функциями
SELECT deptno, enam, hiredate
    FROM (
        SELECT deptno, ename, hiredate,
        row_number() over(partition by
        deptno order by hiredate desc) rnk
        FROM scott.emp
    )
    WHERE rnk = 1
    ORDER BY hiredate DESC;


-- 2024 03 15

-- Задание 2
-- Найдите все отделы, не имеющие служащих используя подзапрос.
-- Вывести в результирующие столбцы: deptno, dname

-- Вариант - 1
SELECT deptno, dname
    FROM scoot.dept
    WHERE deptno not in
        (SELLECT deptno FROM scott.emp)

-- Вариант - 2
SELECT deptno, dname
    FROM scott.dept d
    WHERE not exist
        (SELECT 1 FROM scott.emp e WHERE d.deptno = e.deptno)


-- 2024 03 16


-- Задание 1
-- Выбрать те отделы, где число сотрудников больше трех и средняя зарплата больше средней
-- зарплаты отдела 30. Вывести в результирующие столбцы: номер отдела, средняя зарплата.
SELECT deptno, average
    FROM (SELECT count(*), avg(sal) average, deptno
        FROM scott.emp
        GROUP BY deptno
        HAVING count(*) > 3
            and avg(sal) > (SELECT avg(sal)
                            FROM scott.emp
                            WHERE deptno = 30)
        );


-- Задание 2
-- Получить список сотрудников, не имеющих подчиненных.
-- Вывести результирующие столбцы: EMPNO, ENAME, JOB, DEPTNO

-- Вариант 1 (не правильный, с использованием not in)
SELECT empno, ename, job, deptno
    FROM scott.emp e
    WHERE e.empno not in (SELECT e_in.mgr
                                FROM scott.emp e_in);

-- Вариант - 2 (правильный, с использованием NOT EXISTS)
SELECT empno, ename, job, deptno
    FROM scott.emp e
    WHERE NOT EXISTS
            (SELECT 1
                FROM scott.emp e_in
                WHERE e.empno = e_in.mgr);
    
-- Вариант - 3 (альтернативный, нетривиальный, необязательно оптимальный, но интересный)
SELECT empno, ename, job, deptno
    FROM scott.emp
    minus
    SELECT e.empno, e.ename, e.job, e.deptno
    FROM scott.emp e, scott.emp e2
    WHERE e.empno = e2.mgr



-- 2024 03 25

-- Собеседование SQL (Часть 5)
-- https://youtu.be/Q6OdYT9VZOY?list=PLJXRI1dijmWC_TsUe1Tr9bMyjtyvG-F6X

-- Задание 1

-- Необходимо написать запрос, который позволит понять, идентичны ли данные в
-- двух таблицах. Порядок хранения данных в таблицах значения не имеет

-- Пример данных:

-- T1:
-- a b
-- 1 1
-- 2 2
-- 2 2
-- 3 3
-- 4 4

-- T2:
-- a b
-- 1 1
-- 2 2
-- 3 3
-- 3 3
-- 4 4


-- Решение - Вариант 1 (НО он может быть неверным)
SELECT sum(a)sm_a, sum(b) sm_b, 'tmp1' as fld
    FROM t1
    UNION ALL
    SELECT sum(a), sum(b), 'tmp2' as fld
    FROM t2;


-- Решение - Вариант 2
-- Немного сложнее, но вместе с этим чуть интереснее
-- Необходимо проверить индентичность с двух сторон
select a, b, count(1) cnt from t1 group by a, b
minus
select a, b, count(1) cnt from t2 group by a, b;

select a, b, count(1) cnt from t2 group by a, b
minus
select a, b, count(1) cnt from t1 group by a, b;
-- minus вычитает значения первое из второго...


-- Задание 2
-- Имеется таблица без первичного ключа. Известно, что в таблице
-- имеется задвоение данных.
-- Необходимо удалить дубликаты из таблицы

-- Пример данных:
-- a b
-- 1 1
-- 2 2
-- 2 2
-- 3 3
-- 3 3
-- 3 3

-- Требумый результат:
-- a b
-- 1 1
-- 2 2
-- 3 3

-- Решение
SELECT
    FROM t
    WHERE rowid in (
        SELECT rowid
            FROM
                (
                    select a, b, rowid,
                        row_number() over(partition by a, b
                            order by rowid) rnk
                    from t
                )
        WHERE rnk > 1           
    );


-- Задание 3 (Со звездочкой! Нужно хорошенько подумать, как его решать)
-- Имеется таблица с данными по платежным документам.
-- Необходимо написать запрос, который выведет все документы того типа,
-- которого за все время было по сумме больше всего.
-- Если таких типов несколько, то вывести все такие типы.
-- Для каждой строки результата вывести промежуточную сумму 
-- платежей данного типа от самого раннего до текущего платежа включительно.

-- Решение - часть 1
select p.*, sum(pay_sum) over
            (partition by pay_type) ps
    from payments p

-- Решение - часть 2
SELECT tmp.id, pay_type, pay_date, pay_sum, ps,
        dense_rank() over (order by ps desc) rown
    FROM
        (SELECT p.*, sum(pay_sum)
            over (partition by pay_type) ps
            FROM scott.payments p) tmp

-- Решение - итог
SELECT id, pay_type, pay_date, pay_sum, sum (pay_sum) (over partition by pay_type order by pay_date) sm
    FROM (SELECT tmp.id, pay_type, pay_date, pay_sum, ps, dense_rank() over (order by ps desc) rown
        FROM (SELECT p.*, sum(pay_sum) over (partition by pay_type) ps
            FROM scott.payments p) tmp
    )
WHERE rown = 1
    ORDER BY id;
    


-- 2024 03 26

-- Собеседование по SQL (Часть 6)

-- Задание 1

-- -- Имеется база данных со следующей структурой:

-- Salespeople
-- salespeople_id -> Orders.salespeople_id
-- salespeople_name
-- salespeople_comm
-- salespeople_city

-- Orders
-- orders_id
-- orders_count
-- orders_date
-- customers_id
-- salespeople_id

-- Customers
-- customers_id -> Orders.customers_id
-- customers_name
-- customers_city
-- customers_rating

-- Написать запрос на SQL,
-- выводящий все заказы, оформленные продавцом Петровым на клиентов из города Москвы

-- Решение
SELECT ord.*
    FROM salespeople sp
        JOIN orders ord
        ON s.salespeople_id = ord.salespeople_id
        WHERE customers_id in (SELECT customers_id
                                FROM customers cm
                                WHERE lower(com.customers_city) = 'москва')
        AND lower(sp.salespeople_name) = 'петров';


-- Задание 2

-- Используя Базу Данных из предыдущего задания, написать на понятном пользователю
-- языке, какие данные возвращает приведенный ниже SQL-запрос:
SELECT c.c_name
    FROM customers c
    WHERE c.rating > (SELECT avg(c.rating)
                        FROM customers c
                        WHERE c.c_city='Санкт-Петербург')
        AND c.c_id in (SELECT o.c_id
                        FROM orders o
                        WHERE o.o_date BETWEEN sysdate-31 and sysdate)
                            
-- Решение - Часть 1
-- Разбиваем наш запрос мысленно на 3 части.
-- Будем описывать 1ю и 2ю части независимо.
SELECT c.c_name
    FROM customers c
    WHERE c.rating > (SELECT avg(c.rating)
                        FROM customers c
                        WHERE c.c_city='Санкт-Петербург')
        AND c.c_id in (SELECT o.c_id
                        FROM orders o
                        WHERE o.o_date BETWEEN sysdate-31 and sysdate)
                                            -- systdate-31 это на 31 день назад
-- Решение - Часть 2

-- 1я часть
SELECT avg(c.rating)
    FROM customers c
    WHERE c.c_city='Санкт-Петербург'

-- Получаем средний арифметический рейтинг среди всех покупателей по городу Санкт-Петербург.
-- По сути средний показатель по городу

-- 2я часть
SELECT o.c_id
    FROM orders o
    WHERE o.o_date BETWEEN sysdate-31 and sysdate

-- Решение - итог
SELECT c.c_name
    FROM customers c
    WHERE c.rating > (SELECT avg(c.rating)
                        FROM customers c
                        WHERE c.c_city='Санкт-Петербург')
            AND c.c_id in (SELECT o.c_id
                            FROM orders o
                            WHERE o.o_date BETWEEN sysdate-31 and sysdate)

-- Этим запросом мы выводим всех покупаетелей,
-- рейтинг которых боьтше среднего уровня по Санкт-Петербургу,
-- среди тех покупателей, которые офрмили заказы на последний 31 день.

-- В резщультатах запросов мы получим имена покупателей.
