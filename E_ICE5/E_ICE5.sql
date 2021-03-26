#Database Creation and Data Insertion
create schema ICE5;
use ICE5;

CREATE TABLE ICE5.student LIKE DM.student;
CREATE TABLE ICE5.room LIKE DM.room;
CREATE TABLE ICE5.registration LIKE DM.registration;
CREATE TABLE ICE5.qualification LIKE DM.qualification;
CREATE TABLE ICE5.performance LIKE DM.performance;
CREATE TABLE ICE5.faculty LIKE DM.faculty;
CREATE TABLE ICE5.course LIKE DM.course;
CREATE TABLE ICE5.assessment LIKE DM.assessment;

INSERT ICE5.student
SELECT *
FROM DM.student;

INSERT ICE5.room
SELECT *
FROM DM.room;

INSERT ICE5.registration 
SELECT *
FROM DM.registration;

INSERT ICE5.qualification 
SELECT *
FROM DM.qualification;

INSERT ICE5.performance 
SELECT *
FROM DM.performance;

INSERT ICE5.faculty 
SELECT *
FROM DM.faculty;

INSERT ICE5.course 
SELECT *
FROM DM.course;

INSERT ICE5.assessment 
SELECT *
FROM DM.assessment;

#a
select s.sid, sname, cid
from student s, registration r
where s.sid = r.sid and semester = 'I-2001';

#b
select q.fid, fname
from qualification q, faculty f
where q.fid = f.fid and extract(year from date_qualified)>1995;

#c
select cname, c.cid 
from qualification q, faculty f, course c
where q.fid = f.fid and q.cid = c.cid and fname = 'Ama'
order by cid desc;

#d
select distinct q.fid, fname
from qualification q, faculty f
where q.fid = f.fid
order by fname asc;

#e
select sid
from registration r, course c
where r.cid = c.cid and semester = 'I-2001' and cname = 'Syst Analysis';

#f
select s.sid, sname
from student s, registration r, course c
where s.sid = r.sid and r.cid = c.cid and semester = 'I-2001' and cname = 'Syst Analysis';

#g
select cname, r.cid, sname
from course c, registration r, student s
where s.sid = r.sid and r.cid = c.cid and sname like 'a%';

#h
select distinct s.sid, sname
from student s, registration r, faculty f, qualification q
where s.sid = r.sid and r.cid = q.cid and f.fid = q.fid
and fname = 'Berry';

#i
select f.fid, fname, cid
from faculty f left outer join qualification q
on f.fid = q.fid;

#j
select f.fid, fname, cname
from faculty f left outer join qualification q on f.fid = q.fid 
left outer join course c on q.cid = c.cid;

#k
select f.fid, fname, count(distinct cid) as CourseCanTeach
from faculty f left outer join qualification q
on f.fid = q.fid
group by f.fid, fname;

#l
select s.sid, sname, count(distinct r.sid) as NumCoursesRegistered
from student s left outer join registration r
on s.sid = r.sid and semester = 'I-2002'
group by s.sid, sname;

#m
select c.cid, cname, count(distinct sid) as NumOfStudents
from course c left outer join registration r
on c.cid = r.cid and semester = 'I-2002'
group by c.cid, cname;

#n 
select sid, fid, sname
from student s, faculty f
where sname = fname;

#o
select sid, sname, fid, fname
from student s, faculty f
where sname <> fname;

#p
select cid, sid, sum(weight*mark) as FinalMark
from assessment a, performance p
where a.aid = p.aid
group by cid, sid;

#q
select sid
from registration r, course c
where r.cid = c.cid and cname in ('Database', 'Networking')
group by sid
having count(distinct r.cid) = 2;

#r
select q.fid
from course c, qualification q
where c.cid = q.cid and cname in ('Syst Analysis', 'Syst Design')
group by q.fid
having count(distinct q.cid) = 1;

#s
select q1.fid, q2.fid, cname
from qualification q1, qualification q2, course c
where q1.cid = q2.cid and q1.cid = c.cid and q1.fid < q2.fid;

#t
select r1.rid, r2.rid, r1.type, r1.capacity
from room r1, room r2
where r1.type = r2.type and r1.capacity = r2.capacity and r1.rid < r2.rid;

#u
select s1.sname, s2.sname, cname, r1.semester
from student s1, student s2, registration r1, registration r2, course c
where s1.sid = r1.sid and s2.sid = r2.sid and r1.cid = c.cid and r1.cid = r2.cid and r1.semester = r2.semester and s1.sid < s2.sid;

select s1.sname, s2.sname, cname, r1.semester
from student s1, student s2, registration r1, registration r2, course c
where s1.sid = r1.sid and s2.sid = r2.sid 
and r1.cid = r2.cid and r1.semester = r2.semester 
and r1.cid = c.cid and s1.sid < s2.sid;

