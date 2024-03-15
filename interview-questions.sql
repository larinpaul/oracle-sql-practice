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


    