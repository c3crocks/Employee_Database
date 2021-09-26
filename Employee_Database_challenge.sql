-- Use Dictinct with Orderby to remove duplicate rows
select * from unique_titles;
SELECT distinct on (re.emp_no)
 	re.emp_no,
    re.first_name,
    re.last_name,
    re.title
into unique_titles
   FROM retirement_elig_new re
     JOIN employees e ON re.emp_no = e.emp_no
  WHERE e.birth_date >= '1952-01-01'::date AND e.birth_date <= '1955-12-31'::date
  ORDER BY re.emp_no,to_date desc;
  
  


select 
	count(emp_no) as count,	title
into retiring_titles
from unique_titles
group by title
ORDER BY count(emp_no) DESC;


select distinct on (e.emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
into mentorship_eligibilty
from employees e
inner join dept_emp de on
	e.emp_no = de.emp_no
inner join titles t  on
	e.emp_no = t.emp_no
where 
	de.to_date = '9999-01-01'
	and 
		(e.birth_date between '1965-01-01' and '1965-12-31')
		