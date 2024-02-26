-- 2024 02 27

select case when job = 'CLERK' then 'КЛЕРК' end as job_rus,
        0.*
    from scott.emp e

select case when job = 'CLEKR' then 'КЛЕРК' else 'ИНАЯ ДОЛЖНОСТЬ' and as job_rus,
        0.*
    from scott.emp e

-- кейс можно также использовать в столбик...
select
    case when job = 'CLERK' then 'КЛЕРК' else 'ИНАЯ ДОЛЖНОСТЬ' end as job_Rus,
    case
        when job = 'CLERK' then 'КЛЕРК' -- в блоке when можно указывать как одно поле, так и набор полей
        when job = 'ANALYST' then 'Аналитик'
    end as job_rus_2,
    e.*
from scott.emp e

select case when job = 'CLERK' then 'КЛЕРК' else 'ИНАЯ ДОЛЖНОСТЬ' end as job_rus,
    case
        when job = 'CLERK' or job = 'Clerker' then 'КЛЕРК'
            when job = 'ANALYST' then 'Аналитик'
        end as job_rus_2,
        e.*
    from scott.emp e

select case when job = 'CLERK' then 'КЛЕРК' else 'ИНАЯ ДОЛЖНОСТЬ' end as job_rus,
    case
        when job in ('CLERK', 'SALESMAN') then 'КЛЕРК'
        when job = 'ANALYST' then 'Аналитик'
    end as job_rus_2,
    e.*
from scott.emp e

select case when job = 'CLERK' then 'КЛЕРК' else 'ИНАЯ ДОЛЖНОСТЬ' end as job_rus,
    case
        when job in ('CLERK', 'SALESMAN') or sal < 1000 then 'КЛЕРК'
            when job = 'ANALYST' then 'Аналитик'
    end as job_rus_2,
    e.*
from scott.emp e

select case when job = 'CLERK' then 'КЛЕРК' else 'ИНАЯ ДОЛЖНОСТЬ' end as job_rus,
    case
        when job in ('CLERK', 'SALESMAN') and sal < 3000 then 'КЛЕРК'
        when job = 'ANALYST' then 'Аналитик'
        end as job_rus_2,
        e.*
    from scott.emp e

select case when job = 'CLERK' then 'КЛЕРК' else 'ИНАЯ ДОЛЖНОСТЬ' end as job_rus,
    case
        when job in ('CLERK', 'SALESMAN') and sal < 3000 then 'КЛЕРК'
            when job = 'ANALYST' then 'Аналитик'
        end as job_rus_2,
        case
            when sal = case when sal < 1000 then 800 end = sal
                then 'low_Sal'
                    end vv,
        e.*
    from scott.emp e

select case when job = 'CLERK' then 'КЛЕРК' else 'ИНАЯ ДОЛЖНОСТЬ' end as job_rus,
    case
        when job in ('CLERK', 'SALESMAN') and sal < 3000 then 'КЛЕРК'
            when job = 'ANALYST' then 'Аналитик'
        end as job_rus_2,
        case
            when sal = case when sal < 1000 then 800 end = sal
                then 'low_Sal'
                    end vv,
        case job
            when 'CLERK' then 'КЛЕРК'
                when 'ANALYST' then 'Аналитик'
                    else 'другое'
                    end rr,
        e.*
    from scott.emp e
where jon = case when job = 'CLERK' then 20 end;

select * from scott.emp;
