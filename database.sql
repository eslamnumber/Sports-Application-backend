create database Mydatabase; 
use Mydatabase
GO
CREATE procedure createAllTables
AS
    CREATE TABLE userSystem(
        username VARCHAR(20) primary key not null,
        password VARCHAR(20) not NULL,
    )
    CREATE TABLE admin(
    id int primary key IDENTITY not null,
    name VARCHAR(20) not null,
    username VARCHAR(20) not null,
    CONSTRAINT admin_FK FOREIGN KEY (username) REFERENCES userSystem (username) 
    on DELETE CASCADE on UPDATE CASCADE)
    CREATE TABLE SportAssociationManger(
        id int PRIMARY key identity not null,
        name VARCHAR(20) not NULL,
        username VARCHAR(20),
        CONSTRAINT SportAssociation_FK FOREIGN KEY (username) REFERENCES userSystem (username)
        on DELETE CASCADE on UPDATE CASCADE
    )

    CREATE TABLE fans(
        National_id VARCHAR(20) PRIMARY key not NULL,
        username VARCHAR(20),
        name VARCHAR(20) not null,
        phone_number VARCHAR(20) not null,
        address VARCHAR(20) not null,
        birthdate DATETIME not null,
        status BIT default 1,
        CONSTRAINT fans_FK FOREIGN KEY (username) REFERENCES userSystem (username)
        on DELETE CASCADE on UPDATE CASCADE
    )
    drop table fans
    CREATE TABLE Club (
        id int primary key IDENTITY,
        name VARCHAR(20) not null,
        location VARCHAR(20) not null,
    )
        
    CREATE TABLE ClubRepresentative(
        id int PRIMARY key IDENTITY,
        name VARCHAR(20) not null,
        club_ID int,
        username VARCHAR(20) not null,
        CONSTRAINT ClubRepresentative_FK FOREIGN KEY (username) REFERENCES userSystem (username)
        on DELETE CASCADE on UPDATE CASCADE,
        CONSTRAINT ClubRepresentative_FK2 FOREIGN KEY (club_ID) REFERENCES club (id)
        on DELETE CASCADE on UPDATE CASCADE 
    )
    CREATE TABLE Stadium(
        id int primary key IDENTITY,
        name VARCHAR(20) not null,
        status bit default 1,
        locaation varchar(20) not null,
        capcity int not null,
    )
    CREATE TABLE StadiumManger(
        id int primary key IDENTITY,
        name VARCHAR(20),
        Stadium_ID INT,
        username VARCHAR(20),
        CONSTRAINT StadiumManger_FK FOREIGN KEY (username) REFERENCES userSystem (username)
        on DELETE CASCADE on UPDATE CASCADE,
        CONSTRAINT StadiumManger_FK2 FOREIGN KEY (Stadium_ID) REFERENCES Stadium (id)
        on DELETE CASCADE on UPDATE CASCADE,
    )


    CREATE TABLE match(
        id int primary key IDENTITY,
        StartTime DATETIME not null,
        EndTime DATETIME not null,
        Club_Host_ID int ,
        CONSTRAINT match_FK_Host FOREIGN KEY (Club_Host_ID) REFERENCES club,
        Club_Guest_ID int ,
        CONSTRAINT match_FK_Guest FOREIGN KEY (Club_Guest_ID) REFERENCES club,
        Stadium_ID INT  
        CONSTRAINT match_FK_Stadium FOREIGN KEY (Stadium_ID) REFERENCES stadium on DELETE CASCADE on UPDATE CASCADE,
    )
    CREATE TABLE HostRequest(
        id int IDENTITY not null,
        status VARCHAR(20) default 'unhandeled',
        Match_id int,
        CONSTRAINT HostRequest_FK_match FOREIGN KEY (Match_id) REFERENCES match
        on DELETE CASCADE on UPDATE CASCADE,
        ST_Manger_ID int,
        CONSTRAINT HostRequest_FK_st FOREIGN KEY (ST_Manger_ID) REFERENCES StadiumManger,
        Club_Representative_ID int,
        CONSTRAINT HostRequest_FK_clubrep FOREIGN KEY (Club_Representative_ID) REFERENCES ClubRepresentative 
        on DELETE CASCADE on UPDATE CASCADE   
    )
    CREATE TABLE Ticket(
        id Int primary key IDENTITY not null,
        status BIT default 1,
        Match_ID int not null,
        CONSTRAINT Ticket_FK_match FOREIGN KEY (Match_ID) REFERENCES match
    )
    CREATE table TicketBuyingTransactions(
        fan_national_ID varchar(20) not null,
        CONSTRAINT TicketBuyingTransactions_fanID FOREIGN KEY (fan_national_ID) REFERENCES fans on DELETE CASCADE on UPDATE CASCADE,
        ticket_ID int not null, 
        CONSTRAINT TicketBuyingTransactions_ticketID FOREIGN KEY (ticket_ID) REFERENCES ticket on DELETE CASCADE on UPDATE CASCADE,
        CONSTRAINT pk_id PRIMARY KEY(fan_national_ID,ticket_ID)
    )
    drop procedure createAllTables
    EXECUTE createAllTables
GO
CREATE PROCEDURE dropAllTables
AS
    drop table TicketBuyingTransactions
    drop TABLE Ticket 
    drop TABLE HostRequest
    drop TABLE match
    drop TABLE StadiumManger
    drop table Stadium 
    drop table ClubRepresentative
    DROP TABLE Club 
    DROP TABLE fans
    DROP TABLE SportAssociationManger
    DROP TABLE admin
    DROP TABLE userSystem

drop PROCEDURE dropAllTables
EXECUTE dropAllTables

GO
CREATE Procedure dropAllProceduresFunctionsViews
AS

drop Procedure createAllTables,dropAllTables,clearAllTables,addAssociationManager,addNewMatch,deleteMatch,
deleteMatchesOnStadium,addClub,addTicket,deleteClub,addStadium,deleteStadium,blockFan,unblockFan,addRepresentative,
addHostRequest,addStadiumManager,acceptRequest,rejectRequest,addFan,purchaseTicket,updateMatchHost


drop view allAssocManagers,allClubRepresentatives,
allStadiumManagers,allFans,allMatches,allTickets,
allCLubs,allRequests,allStadiums,clubsWithNoMatches,
matchesPerTeam,clubsNeverMatched

drop function viewAvailableStadiumsOn
,allUnassignedMatches,allPendingRequests,
upcomingMatchesOfClub,availableMatchesToAttend,
clubsNeverPlayed,matchWithHighestAttendance,
matchesRankedByAttendance,requestsFromClub

EXECUTE dropAllProceduresFunctionsViews

GO
CREATE PROCEDURE clearAllTables 
AS  

    alter table TicketBuyingTransactions
    DROP CONSTRAINT TicketBuyingTransactions_fanID, TicketBuyingTransactions_ticketID 
    truncate table TicketBuyingTransactions
 

    alter table Ticket
    DROP CONSTRAINT Ticket_FK_match
    truncate table Ticket
 


    alter table HostRequest
    DROP CONSTRAINT HostRequest_FK_match,HostRequest_FK_st, HostRequest_FK_clubrep
    truncate table HostRequest
    

    alter table match 
    DROP CONSTRAINT match_FK_Host, match_FK_Guest, match_FK_Stadium
    truncate table match
    

    alter table fans
    DROP  CONSTRAINT fans_FK
    truncate table fans 
   


    alter table ClubRepresentative
    DROP CONSTRAINT ClubRepresentative_FK,ClubRepresentative_FK2
    truncate table ClubRepresentative
  

    truncate table Club

    alter table StadiumManger
    DROP CONSTRAINT StadiumManger_FK,StadiumManger_FK2
    truncate table StadiumManger
    
    
    truncate table Stadium

    alter table SportAssociationManger
    DROP CONSTRAINT SportAssociation_FK
    truncate table SportAssociationManger


    alter table admin
    DROP CONSTRAINT admin_FK 
    truncate table admin
    
   

    truncate table userSystem



    alter table TicketBuyingTransactions
    ADD CONSTRAINT TicketBuyingTransactions_fanID FOREIGN KEY (fan_national_ID) REFERENCES fans on DELETE CASCADE on UPDATE CASCADE
    alter table TicketBuyingTransactions
    ADD CONSTRAINT TicketBuyingTransactions_ticketID FOREIGN KEY (ticket_ID) REFERENCES ticket on DELETE CASCADE on UPDATE CASCADE

    alter table Ticket
    ADD CONSTRAINT Ticket_FK_match FOREIGN KEY (Match_ID) REFERENCES match on DELETE CASCADE on UPDATE CASCADE

    alter table HostRequest
    ADD CONSTRAINT HostRequest_FK_match FOREIGN KEY (Match_id) REFERENCES match on DELETE CASCADE on UPDATE CASCADE
    alter table HostRequest
    ADD CONSTRAINT HostRequest_FK_st FOREIGN KEY (ST_Manger_ID) REFERENCES StadiumManger
    alter table HostRequest
    ADD CONSTRAINT HostRequest_FK_clubrep FOREIGN KEY (Club_Representative_ID) REFERENCES ClubRepresentative on DELETE CASCADE on UPDATE CASCADE 


    alter table match 
    ADD CONSTRAINT match_FK_Host FOREIGN KEY (Club_Host_ID) REFERENCES club
    alter table match 
    ADD CONSTRAINT match_FK_Guest FOREIGN KEY (Club_Guest_ID) REFERENCES club
    alter table match 
    ADD CONSTRAINT match_FK_Stadium FOREIGN KEY (Stadium_ID) REFERENCES stadium on DELETE CASCADE on UPDATE CASCADE

    alter table fans 
    ADD CONSTRAINT fans_FK 
    FOREIGN KEY (username) REFERENCES userSystem (username) on DELETE CASCADE on UPDATE CASCADE

    alter table ClubRepresentative
    ADD CONSTRAINT ClubRepresentative_FK
    FOREIGN KEY (username) REFERENCES userSystem (username) on DELETE CASCADE on UPDATE CASCADE
    alter table ClubRepresentative 
    add CONSTRAINT ClubRepresentative_FK2 FOREIGN KEY (club_ID) REFERENCES club (id)
    on DELETE CASCADE on UPDATE CASCADE 

    alter table StadiumManger
    ADD CONSTRAINT StadiumManger_FK
    FOREIGN KEY (username) REFERENCES userSystem (username) on DELETE CASCADE on UPDATE CASCADE
    alter table StadiumManger
    ADD CONSTRAINT StadiumManger_FK2 FOREIGN KEY (Stadium_ID) REFERENCES Stadium (id) on DELETE CASCADE on UPDATE CASCADE

    alter table admin 
    ADD  CONSTRAINT admin_FK 
    FOREIGN KEY (username) REFERENCES userSystem (username) on DELETE CASCADE on UPDATE CASCADE

    alter table SportAssociationManger
    ADD CONSTRAINT SportAssociation_FK 
    FOREIGN KEY (username) REFERENCES userSystem (username) on DELETE CASCADE on UPDATE CASCADE

drop PROCEDURE clearAllTables 
EXECUTE clearAllTables

GO
CREATE VIEW allAssocManagers
AS
SELECT name, username FROM SportAssociationManger

GO
CREATE view allClubRepresentatives 
AS 
SELECT e.username, e.name as Representative_name ,c.name as club_name 
from ClubRepresentative e INNER JOIN Club c on e.id = c.Club_Representative_ID

GO 
CREATE VIEW allStadiumManagers
as 
SELECT m.name as manger_name,m.username,s.name as Stadium_name 
from StadiumManger m INNER JOIN Stadium s on m.id = s.manger_id

GO
CREATE VIEW allFans
AS
select f.name,f.National_id,f.birthdate,f.status from fans f 

GO
CREATE VIEW allCLubs
AS
select name,location from Club

GO
create view allStadiums
AS 
SELECT name, locaation,[status],capcity from Stadium

GO 
CREATE VIEW allRequests
AS
SELECT c.name as Club_Representative_name ,s.name as Stadium_manger_name ,[status]
from HostRequest h inner JOIN StadiumManger s on h.ST_Manger_ID=s.id inner JOIN ClubRepresentative c on c.id=h.Club_Representative_ID

GO 
Create VIEW allMatches
AS
select c1.name as clubhost_name, c2.name as clubguest_name ,m.StartTime from Match m
INNER JOIN  Club c1 on  m.Club_Host_ID=c1.id
INNER JOIN  Club c2 on m.Club_Guest_ID=c2.id
where c1.id <> c2.id 

GO
CREATE VIEW allTickets 
AS
select c1.name as club_name , c2.name as secondClub_name , s.name , m.StartTime from Match m
INNER JOIN  Club c1 on  m.Club_Host_ID=c1.id
INNER JOIN  Club c2 on m.Club_Guest_ID=c2.id
INNER JOIN Stadium s on m.Stadium_ID=s.id
where c1.id <> c2.id


GO
create proc addNewMatch
@nameofhost varchar(20),
@nameofguest varchar(20),
@starttime datetime ,
@endtime datetime 
as
begin 
DECLARE @name1 varchar(20) , @name2 varchar(20)
DECLARE @date1 datetime , @date2 datetime

select @name1 =name 
from Club 
where name=@nameofhost

select @name2 = name
from Club
where name=@nameofguest

select @date1=StartTime
from match 
where StartTime=@starttime

select @date2=StartTime
from match 
where EndTime=@Endtime

if (@name1 IS NULL OR @name2 IS NULL )
print ('one or the two clubs cannot be found')

else if (@date1 IS NOT NULL OR @date2 IS NOT NULL)
print ('The match cannot be assigned in this time ')

else
insert into match (Club_Host_ID, Club_Guest_ID, StartTime, EndTime)
values ((select id from club where name =@nameofhost), (select id from club where name = @nameofguest),@starttime, @endtime)
end
go 

Create Proc getId
@name varchar(20) ,
@ID INT  OUTPUT
As
BEGIN
Select @ID=C.ID From club C
Where C.name=@name
END

Go
create proc deleteMatch
@nameoffirstClub varchar(20),
@nameofsecondClub varchar(20),
@nameofhostClub varchar(20),
@date dateTime
As
BEGIN 
if(@nameoffirstClub<>@nameofhostClub AND @nameofsecondClub<>@nameofhostClub)
print 'one of the input must be the host '
else 
DECLARE @name1 varchar(20) , @name2 varchar(20)
DECLARE @date1 datetime , @date2 datetime

select @name1 =name 
from Club 
where name=@nameoffirstClub

select @name2 = name
from Club
where name=@nameofsecondClub

select @date1=StartTime
from match 
where StartTime=@date



if (@name1 IS NULL OR @name2 IS NULL )
print ('one or the two clubs cannot be found')

else if (@date1 IS  NULL )
print ('The match in this time cannot be found  ')

else
delete from HostRequest where Match_id=(select id from match where (Club_Host_ID=(select id from club where name =@nameofhostClub)) AND (Club_Guest_ID=(select id from club where (name=@nameofsecondClub AND name<>@nameofhostClub) OR name =@nameoffirstClub)) )
delete from match where (Club_Host_ID=(select id from club where name =@nameofhostClub)) AND (Club_Guest_ID=(select id from club where (name=@nameofsecondClub AND name<>@nameofhostClub) OR name =@nameoffirstClub)) 
end

drop proc deleteMatch

GO
GO
CREATE PROCEDURE addTicket @name_host VARCHAR(20) , @name_competing_club VARCHAR(20) , @start_time DATETIME 
AS
DECLARE @temp INT
SELECT @temp = m.id from match m inner JOIN Club c on m.Club_Host_ID = c.id inner join club c2 on c2.id = m.Club_Guest_ID 
where c.id <> c2.id AND c.name = @name_host AND c2.name = @name_competing_club
DEclare @temp2 int 
SELECT @temp2 = s.capcity from match m inner join stadium s on @temp = s.id
while @temp2 > 0 
    BEGIN 
    INSERT into Ticket([status],Match_ID) VALUES(1,@temp) 
    set @temp2 = @temp2 -1
END
GO
CREATE PROC addClub
@nameoftheclub varchar(20),
@location varchar (20)
As 
begin 
DECLARE @name varchar(20)
select @name =name 
from Club
where @nameoftheclub=name 
if (@name IS NOT NULL)
print 'this club is already exist '
else
insert into club (name, location) values(@nameoftheclub, @location)
end 

GO
create proc deleteClub
@nameoftheclub varchar(20)
as 
begin 
DECLARE @name varchar(20)
DECLARE @id int 
select @name =name , @id =id
from Club
where @nameoftheclub=name 
if (@name IS  NULL)
print 'this club cannot be found  '
else
begin 
delete from HostRequest where Match_id =(select id from match where( Club_Host_ID=@id OR match.Club_Guest_ID=@id ))
delete from ClubRepresentative where club_ID=@id
delete from TicketBuyingTransactions where ticket_ID=(select id from Ticket where Match_ID= (select id from match where( Club_Host_ID=@id OR match.Club_Guest_ID=@id )))
delete from Ticket where Match_ID=(select id from match where( Club_Host_ID=@id OR match.Club_Guest_ID=@id ))
delete from match where Club_Host_ID=@id OR match.Club_Guest_ID=@id 
delete Club where name =@name  
end 
end



GO
create proc deleteStadium
@name varchar(20)
as 
begin 
DECLARE @name1 varchar(20)
select @name1 =name 
from Stadium
where @name=name 
if (@name1 IS  NULL)
print 'this Stadium  cannot be found'
else
begin
delete from HostRequest where ST_Manger_ID =(select id from StadiumManger where Stadium_ID=(select id from Stadium where name =@name ))
delete from StadiumManger where Stadium_ID = (select id from Stadium where name=@name )
delete from TicketBuyingTransactions where ticket_ID=(select id from Ticket where Match_ID= (select id from match where Stadium_ID=(select id from Stadium where name=@name)))
delete from Ticket where Match_ID =(select id from match where Stadium_ID=(select id from Stadium where name=@name))
delete from match where Stadium_ID =(select id from Stadium where name =@name)
delete from Stadium where name =@name 

end
end 

GO
create proc unblockFan
@id int 
as 
begin 
update fans 
set status =1
where
 fans.National_id=@id 
end 
go 

GO
create function allUnassignedMatches(@name varchar(20))
returns table 
AS 
return (
select c.name as clubhost_name ,c2.name as clubguest_name, m.StartTime 
from 
club c left outer join match m on c.id=m.Club_Host_ID inner join club c2 on m.Club_Guest_ID = c2.id
where m.Stadium_ID is NULL and c.name = @name
)


GO
create function allPendingRequests(@username varchar(20))
returns table 
as 
return (
select cr.name as name_of_the_club_Representative , c1.name as nameoftheguestclub ,m.StartTime 
from StadiumManger sm inner join HostRequest h  on sm.id=h.ST_Manger_ID inner join ClubRepresentative cr on cr.id=h.Club_Representative_ID inner join match m on m.id =h.Match_id 
inner join Club c on c.id=m.Club_Host_ID 
inner join Club c1 on c1.id=m.Club_Guest_ID 
where h.status='unhandeled' and sm.username = @username
)

GO
create proc rejectRequest
@stadium_manger_username VARCHAR(20) , @hosting_club_name VARCHAR(20) , @name_guest_club VARCHAR(20) ,@start_time DATETIME
as 
DECLARE @StadiumManger_Id int , @Club_Host_ID int ,@Club_Guest_ID int ,  @match_id INT
SELECT @StadiumManger_Id = stm.id from StadiumManger stm where stm.username = @stadium_manger_username
SELECT @Club_Host_ID = c.id from club c where c.name = @hosting_club_name 
SELECT @Club_Guest_ID = c.id from club c where c.name = @name_guest_club 
SELECT @match_id = m.id from match m where m.Club_Host_ID = @Club_Host_ID AND m.Club_Guest_ID = @Club_Guest_ID 
AND m.StartTime = @start_time 
UPDATE HostRequest set status = 'rejected' where Match_id = @match_id
update match set stadium_ID = NULL where id =@match_id
GO
CREATE PROCEDURE acceptRequest
@stadium_manger_username VARCHAR(20) , @hosting_club_name VARCHAR(20) , @name_guest_club VARCHAR(20) ,@start_time DATETIME
AS
DECLARE @StadiumManger_Id int , @Club_Host_ID int ,@Club_Guest_ID int ,  @match_id INT ,@stadium_id int 
SELECT @StadiumManger_Id = stm.id from StadiumManger stm where stm.username = @stadium_manger_username
SELECT @stadium_id = stm.stadium_id from StadiumManger stm where stm.username = @stadium_manger_username
SELECT @Club_Host_ID = c.id from club c where c.name = @hosting_club_name 
SELECT @Club_Guest_ID = c.id from club c where c.name = @name_guest_club 
SELECT @match_id = m.id from match m where m.Club_Host_ID = @Club_Host_ID AND m.Club_Guest_ID = @Club_Guest_ID 
AND m.StartTime = @start_time 
UPDATE HostRequest set status = 'accepted' where Match_id = @match_id
update match set stadium_ID = @stadium_id where id =@match_id
exec addticket @hosting_club_name, @name_guest_club, @start_time

GO

create function upcomingMatchesOfClub(@name varchar(20))
returns table 
as 
return (
select c.name as firstname, c1.name as secondname , m.StartTime , s.name
from match m inner join Club c on m.Club_Host_ID =c.id inner join Club c1 on c1.id=m.Club_Guest_ID inner join Stadium s on s.id=m.Stadium_ID 
where 
(@name =c.name OR @name =c1.name) and m.StartTime > CURRENT_TIMESTAMP
)


GO
create proc purchaseTicket
@nationalid varchar(20),
@hname varchar(20),
@gname varchar(20),
@Sdate datetime 
as 
begin 
update Ticket 
set status =0 
update TicketBuyingTransactions set fan_national_ID=@nationalid
from match m inner join Ticket t on t.Match_ID=m.id inner join Club c on c.id = m.Club_Host_ID inner join Club c2 on c2.id=m.Club_Guest_ID inner join TicketBuyingTransactions tt on tt.ticket_ID=t.id
where c.name = @hname AND c2.name =@gname AND @Sdate=m.StartTime AND tt.fan_national_ID IS  NULL AND t.status=1
end
go 


create function clubsNeverPlayed(@name varchar(20))
returns table 
as 
return (
select c.name as name1 ,c1.name as name2
from Club c cross join Club c1f
where 
(c.name = @name OR c1.name =@name ) AND (c.name<>@name OR c1.name <>@name) AND c.id>c1.id
EXCEPT 
(
select c2.name , c4.name
from match m inner join Club c2 on m.Club_Host_ID=c2.id inner join Club c4 on m.Club_Guest_ID=c4.id
where c2.name =@name
union 
select c2.name ,c4.name 
from match m inner join Club c2 on m.Club_Guest_ID=c2.id inner join Club c4 on  m.Club_Host_ID=c4.id 
where c2.name =@name 
)
)


go 
create function matchWithHighestAttendance()
returns table 
as 
return (
select top 1 nameofhost , nameofguest
from (
select   c1.name as nameofhost  , c2.name as nameofguest, m.id ,count(*) as counts
from Ticket t inner join match m on m.id =t.Match_ID inner join Club c1 on c1.id= m.Club_Host_ID inner join Club c2 on c2.id=m.Club_Guest_ID
where t.status=0
GROUP BY m.id ,  c1.name ,c2.name

) t 
ORDER  BY counts DESC
)
 


GO
Create FUNCTION matchesRankedByAttendance
()
returns  table 
As
Return(
Select TOP 200 C1.name AS nameofhost ,C2.name As nameofguest ,COUNT(*) AS capacity From ticket T
INNER JOIN match M ON T.Match_ID=M.id
INNER JOIN Club C1 ON M.Club_Host_ID=C1.id
INNER JOIN Club C2 ON M.Club_Guest_ID=C2.id
Where T.Status=0
Group by C1.Name,C2.Name
order by COUNT(*) DESC
)


GO
create function requestsFromClub(@name varchar(20) , @nameofStadium varchar (20))
returns table 
as 
return (
select c.name as NameofHost  , c1.name as Nameofguest 
from Club c inner join ClubRepresentative r on c.id=r.club_ID inner join match m on m.Club_Host_ID =c.id inner join Club c1 on c1.id=m.Club_Guest_ID inner join HostRequest h on r.id=h.Club_Representative_ID inner join StadiumManger sm on sm.id = h.ST_Manger_ID INNER JOIN Stadium s ON s.id = sm.Stadium_ID
where h.status ='Unhandled' AND s.name =@nameofStadium AND @name=r.name 

)

Go
create PROCEDURE addAssociationManager @name varchar(20),@username varchar(20) , @PASSWORD VARCHAR(20)
AS
INSERT into userSystem VALUES (@username, @password)
INSERT into SportAssociationManger (username,name) VALUES(@username,@name)

---############################

GO
CREATE VIEW clubsWithNoMatches
AS
SELECT c.name
from Club c left OUTER JOIN match m on m.Club_Guest_ID = c.id LEFT OUTER JOIN match m2 on m2.Club_Host_ID=c.id
WHERE c.id is NULL


----#############################

GO
CREATE PROCEDURE deleteMatchesOnStadium @name VARCHAR(20)
AS 
DELETE m from match m inner JOIN stadium s on m.Stadium_ID=s.id where m.StartTime > CURRENT_TIMESTAMP

---###############################


GO
GO
CREATE PROCEDURE addTicket @name_host VARCHAR(20) , @name_competing_club VARCHAR(20) , @start_time DATETIME 
AS
DECLARE @temp INT
SELECT @temp = m.id from match m inner JOIN Club c on m.Club_Host_ID = c.id inner join club c2 on c2.id = m.Club_Guest_ID 
where c.id <> c2.id AND c.name = @name_host AND c2.name = @name_competing_club
DEclare @temp2 int 
SELECT @temp2 = s.capcity from match m inner join stadium s on @temp = s.id
while @temp2 > 0 
    BEGIN 
    INSERT into Ticket([status],Match_ID) VALUES(1,@temp) 
    set @temp2 = @temp2 -1
END

---##################################
select * from Ticket
GO 
CREATE PROCEDURE addStadium 
@name_stadium VARCHAR(20) , @location VARCHAR(20) , @capcity int 
AS
INSERT into Stadium (name,locaation,capcity) VALUES(@name_stadium,@location,@capcity) 



drop proc addStadium
---####################################


GO 
Create View clubsNeverMatched
As
Select c.name As nameoffirst ,c2.name As nameofsecond From Club c
Cross join Club c2
Where c.name<>c2.name AND c.id<c2.id
Except(Select c.name ,c2.name From Club c 
inner join match M ON c.id=M.Club_Host_ID
INNER JOIN Club c2 ON M.Club_Guest_ID=c2.id
UNION
Select c2.name,c.name From Club c 
INNER JOIN Match M ON c.id=M.Club_Host_ID
INNER JOIN Club c2 ON M.Club_Guest_ID=c2.ID)
Go


select * from clubsNeverMatched


GO
CREATE PROCEDURE blockFan
@National_id VARCHAR(20)
AS 
update fans 
set status = 0 WHERE National_id = @National_id

---#####################################

GO
CREATE PROCEDURE addRepresentative
@name_representative VARCHAR(20) , @club_name VARCHAR(20) , @username VARCHAR(20) , @PASSWORD VARCHAR(20) 
AS
DECLARE @temp INT 
SELECT @temp=c.id
from club c
where c.name = @club_name
insert into usersystem VALUES (@username , @password)
INSERT into ClubRepresentative (username,name,club_ID) VALUES(@username,@name_representative,@temp)

----###################################
GO
CREATE PROCEDURE addHostRequest 
@club_name VARCHAR(20) , @stadium_name VARCHAR(20) , @start_time DATETIME
AS
insert into HostRequest (Club_Representative_ID,ST_Manger_ID,Match_id) values ((select id from ClubRepresentative where club_ID=(select id from Club where name=@club_name )),(select id from StadiumManger where Stadium_ID=(select id from Stadium where name=@stadium_name)),(select id from match where StartTime=@start_time))
go


---#####################################

GO 
CREATE PROCEDURE addStadiumManager
@manger_name VARCHAR(20) , @stadium_name VARCHAR(20) , @username VARCHAR(20) , @PASSWORD VARCHAR(20) 
AS
DECLARE @temp INT
SELECT @temp = s.id from stadium s where s.name = @stadium_name
insert into usersystem VALUES (@username , @password)
INSERT into StadiumManger(name,Stadium_ID,username) VALUES(@manger_name,@temp,@username)

---#####################################


GO 
CREATE PROCEDURE addFan
@name VARCHAR(20) , @national_id VARCHAR(20) , @birth_date DATE , @address VARCHAR(20) , @phone_number varchar(20) , @username VARCHAR(20) , @password VARCHAR(20)
AS
insert into userSystem values(@username , @password)
INSERT into fans (National_id,username,name,birthdate,address,phone_number) VALUES(@national_id,@username,@name,@birth_date,@address,@phone_number)
----#######################################

GO
CREATE FUNCTION availableMatchesToAttend
(@date datetime)
RETURNS TABLE
AS
RETURN (
 SELECT c1.name as host_club_name , c2.name as guest_club_name , m.StartTime , s.name as stadium_name
 from match m left outer JOIN ticket t on t.Match_ID = m.id inner join club c1 on m.Club_Host_ID = c1.id inner join 
 club c2 on c2.id = m.Club_Guest_ID inner join stadium s on m.Stadium_id = s.id 
 where m.StartTime < @date AND m.EndTime > @date and t.id is not NULL and c2.id<> c1.id  
)

GO

CREATE FUNCTION viewAvailableStadiumsOn(@date DATETIME)
RETURNS TABLE
AS
RETURN
(
  SELECT s.name, s.locaation, s.capcity
  FROM Stadium s
  WHERE s.status = 1 AND s.id NOT IN
  (
    SELECT m.Stadium_ID
    FROM match m
    WHERE m.StartTime < @date AND m.EndTime > @date
  )
);


---########################################
GO
CREATE PROCEDURE purchaseTicket
@national_id int , @hosting_club_name VARCHAR(20) , @name_competing_club VARCHAR(20) , 
@date DATETIME 
AS
DECLARE @Club_Host_ID int , @Club_Guest_ID int , @match_id INT , @ticket_ID INT
SELECT @Club_Host_ID = c.id from club c where c.name = @hosting_club_name 
SELECT @Club_Guest_ID = c.id from club c where c.name = @name_competing_club
SELECT @match_id = m.id from match m where m.Club_Host_ID = @Club_Host_ID AND m.Club_Guest_ID = @Club_Guest_ID AND m.StartTime = @date 
SELECT @ticket_ID = t.id from ticket t where t.status = 1 AND @match_id = t.match_id 
insert into TicketBuyingTransactions VALUES (@national_id , @ticket_ID)
---########################################

GO 
CREATE PROCEDURE updateMatchHost 
@hosting_club_name VARCHAR(20) , @Club_Guest_name VARCHAR(20) , @start_time DATETIME 
AS
DECLARE @Club_Host_ID int , @Club_Guest_ID int , @match_id INT 
SELECT @Club_Host_ID = c.id from club c where c.name = @hosting_club_name 
SELECT @Club_Guest_ID = c.id from club c where c.name = @Club_Guest_name 
SELECT @match_id = m.id from match m 
where m.Club_Host_ID = @Club_Host_ID AND m.Club_Guest_ID = @Club_Guest_ID AND m.StartTime = @start_time and @Club_Host_ID <> @Club_Guest_ID
DELETE from match where Club_Host_ID = @Club_Host_ID And Club_Guest_ID = @Club_Guest_ID AND StartTime = @start_time
UPDATE match set Club_Host_ID = @Club_Guest_ID where id = @match_id
UPDATE match set Club_Guest_ID = @Club_Host_ID where id = @match_id 

--###################################

GO 
CREATE VIEW matchesPerTeam
AS
SELECT c.name , count(*) as count from club c inner JOIN match m on c.id = m.Club_Host_ID or c.id =m.Club_Guest_ID
where m.StartTime < CURRENT_TIMESTAMP
GROUP BY c.name 

---##################################

go 
create function checkadmin (@username varchar(20) , @password varchar(20))
returns int
AS
begin
DECLARE @check int 
declare @result int
SELECT @result = COUNT(*) FROM fans f inner join userSystem u on f.username=u.username
WHERE f.username = @username and @password = u.password
if @result =1 
begin
set @check =5
end
SELECT @result = COUNT(*) FROM admin a inner join userSystem u on a.username=u.username
WHERE a.username = @username and @password = u.password
if @result =1 
begin
set @check =1
end
SELECT @result = COUNT(*) FROM SportAssociationManger sp inner join userSystem u on sp.username=u.username
WHERE sp.username = @username and @password = u.password
if @result =1 
begin
set @check =2
end
SELECT @result = COUNT(*) FROM ClubRepresentative cr inner join userSystem u on cr.username=u.username
WHERE cr.username = @username and @password = u.password
if @result =1 
begin
set @check =3
end
SELECT @result = COUNT(*) FROM StadiumManger sm inner join userSystem u on sm.username=u.username
WHERE sm.username = @username and @password = u.password
if @result =1 
begin
set @check =4
end
if @check is null 
set @check =0
return @check
end 
go 



create proc addAss(
@name varchar(20),
@username varchar(20),
@password varchar(20)
)
as 
begin
insert into userSystem values (@username, @password )
insert into SportAssociationManger(name, username) values(@name , @username)
end
go


create proc addcr(
@name varchar(20),
@username varchar(20),
@password varchar(20), 
@nameoftheclub varchar(20)
)
as 
begin
insert into userSystem values (@username, @password )
insert into ClubRepresentative(name, username,club_ID) values(@name , @username, (select id from Club where name =@nameoftheclub))
end
go

create function Checks(@username varchar(20))
returns int 
as 
begin 
DECLARE @c int 
select @c =count(*)
from userSystem
where username=@username
IF @c is NULL
SET @c=0
return @c 
end 
go



select * from Stadium


go 
create function findClub(@nameoftheclub varchar(20))
returns int 
as 
begin
DECLARE @c int 
DECLARE @cc int
select @c=count(*) 
from Club 
where name =@nameoftheclub
select @cc =count (*)
from ClubRepresentative
where club_ID =(select id from Club where name =@nameoftheclub)
return @c +@cc
end 


go
create proc addsm(
@name varchar(20),
@username varchar(20),
@password varchar(20), 
@nameofthestadium varchar(20)
)
as 
begin
insert into userSystem values (@username, @password )
insert into StadiumManger(name, username,Stadium_ID) values(@name , @username, (select id from Stadium where name =@nameofthestadium))
end
go 

create function findStadium(@nameofthestadium varchar(20))
returns int 
as 
begin
DECLARE @c int 
DECLARE @cc int 
select @c=count(*) 
from Stadium
where name =@nameofthestadium
select @cc =count (*)
from StadiumManger
where Stadium_ID =(select id from Stadium where name =@nameofthestadium)
return @c +@cc
end 
go 



create proc addfan(@name varchar(20),@username varchar(20), @password varchar(20),@national_ID varchar(20), @phone varchar(20), @birthdate datetime , @address varchar(20) )
as
begin 
insert into userSystem(username, password) values (@username, @password)
insert into fans(name, username,National_id, phone_number,birthdate, address) values (@name, @username, @national_ID, @phone, @birthdate, @address)
end 
go 







------hamed
create proc PurchaseTicket
@ID varchar(20), 
@Hname varchar(20), 
@gname varchar(20), 
@date datetime 
as
insert into TicketBuyingTransactions (fan_national_ID, ticket_ID)(
select tt.fan_national_ID, t.id
from Club c1 inner join match m on c1.id=m.Club_Host_ID inner join Club c2 on c2.id=m.Club_Guest_ID inner join Ticket t on t.Match_ID=m.id inner join TicketBuyingTransactions tt on tt.ticket_ID=t.id 
where tt.fan_national_ID=@ID AND c1.name =@Hname AND c2.name=@gname AND m.StartTime=@date 
)
go
 
create proc UpdateMatchTiming 
@Hname varchar(20), 
@gname varchar(20),
@date datetime , 
@Change datetime 
as
update match 
set StartTime =@Change
where Club_Host_ID=(select id from Club where name =@Hname) AND Club_Guest_ID=(select id from Club where name =@gname) AND  StartTime=@date
go


create view matchesPerTeam
as
select c1.name , count(*)
from Club c1 inner join match m on (m.Club_Host_ID=c1.id OR m.Club_Guest_ID=c1.id) where m.EndTime<CURRENT_TIMESTAMP 
group by c1.name
go

-----------hamed
create function Upcoming()
RETURNS TABLE
AS 
RETURN(
SELECT c.name as HostName, c1.name as GuestName, m.StartTime,m.EndTime
FROM Club c INNER JOIN match m on m.Club_Host_ID=c.id INNER JOIN Club c1 on c1.id=m.Club_Guest_ID AND m.EndTime>CURRENT_TIMESTAMP AND m.StartTime>CURRENT_TIMESTAMP
)
go 

create function Already()
RETURNS TABLE
AS 
RETURN(
SELECT c.name as HostName, c1.name as GuestName, m.StartTime,m.EndTime
FROM Club c INNER JOIN match m on m.Club_Host_ID=c.id INNER JOIN Club c1 on c1.id=m.Club_Guest_ID AND m.StartTime<CURRENT_TIMESTAMP 
)
go 

CREATE FUNCTION Display(@username varchar(20))
RETURNS TABLE 
AS
RETURN (
SELECT c.id, c.name , c.location
FROM ClubRepresentative cr INNER JOIN Club c on cr.club_ID=c.id 
WHERE cr.username=@username 
)
go


CREATE FUNCTION Display1(@username varchar(20))
RETURNS TABLE 
AS
RETURN (
SELECT s.id, s.name , s.locaation, s.capcity , s.status
FROM StadiumManger sm INNER JOIN Stadium s on sm.Stadium_ID=s.id 
WHERE sm.username=@username 
)
go 

create function requests(@username varchar(20))
returns table 
as
return 
(
select  cr.name as ClubRepresentitiveName ,c.name as HostName ,c1.name as GuestName ,m.StartTime,m.EndTime
from StadiumManger sm inner join Stadium s on s.id=sm.Stadium_ID inner join HostRequest h on h.ST_Manger_ID=sm.id inner join match m on m.id=h.Match_id inner join Club c on c.id=m.Club_Host_ID inner join Club c1 on c1.id=m.Club_Guest_ID inner join ClubRepresentative cr on cr.club_ID=c.id
where sm.username=@username
)
go 


CREATE function ViewMatches(@Date datetime )
RETURNS TABLE 
AS 
RETURN 
(
SELECT c.name as HostClubName , c1.name as GuestClubName ,s.name as StadiumName , s.locaation as Location
FROM match m inner join Club c on c.id=m.Club_Host_ID inner join Club c1 on c1.id=m.Club_Guest_ID inner join Stadium s on s.id=m.Stadium_ID
WHERE m.StartTime=@Date 
)
GO




create FUNCTION check_fans2(@nationalid varchar(20))
RETURNs INT
AS
BEGIN
DECLARE @result INT , @temp INT
SELECT @temp = count(*) from fans f where f.national_id = @nationalid
if @temp > 0 
set @result = 1 
ELSE 
set @result = 0
RETURN @result
END



GO
create FUNCTION check_club(@clubname varchar(20))
RETURNs INT
AS
BEGIN
DECLARE @result INT , @temp INT
SELECT @temp = count(*) from club c where c.name = @clubname
if @temp > 0 
set @result = 1 
ELSE 
set @result = 0
RETURN @result
END

GO
create FUNCTION check_stadium(@stadiumname varchar(20))
RETURNs INT
AS
BEGIN
DECLARE @result INT , @temp INT
SELECT @temp = count(*) from stadium s where s.name = @stadiumname
if @temp > 0 
set @result = 1 
ELSE 
set @result = 0
RETURN @result
END

GO
create FUNCTION check_match(@clubhost_name varchar(20), @clubguest_name varchar(20))
RETURNs INT
AS
BEGIN
DECLARE @result INT , @temp INT
SELECT @temp = count(*) from match m inner join club c on m.Club_Host_ID = c.id INNER join club c2 on m.Club_Guest_ID = c2.id where 
c.id <> c2.id and c.name = @clubhost_name and c2.name = @clubguest_name 
if @temp > 0 
set @result = 1 
ELSE 
set @result = 0
RETURN @result
END

GO
CREATE function Checks_Request (@username varchar(20),@clubhost_name varchar(20), @clubguest_name varchar(20),@starttime datetime)
RETURNS int
As
BEGIN 
DECLARE @result int , @temp INT 
SELECT @temp = count(*) from HostRequest h inner join StadiumManger sm on h.ST_Manger_ID = sm.id inner join 
match m on m.id = h.Match_ID inner join club c on m.Club_Host_ID = c.id INNER join club c2 on m.Club_Guest_ID = c2.id 
where 
c.id <> c2.id and c.name = @clubhost_name and c2.name = @clubguest_name and sm.username = @username and m.StarTtime = @starttime
if @temp > 0 
set @result = 1 
ELSE 
set @result = 0
RETURN @result
END


GO
create FUNCTION check_match2(@clubname varchar(20), @starttime datetime)
RETURNs INT
AS
BEGIN
DECLARE @result INT , @temp INT
SELECT @temp = count(*) from match m inner join club c on c.id = m.Club_Host_ID where m.StartTime = @starttime
if @temp > 0 
set @result = 1 
ELSE 
set @result = 0
RETURN @result
END

GO
create FUNCTION check_request2(@clubname varchar(20), @stadiumname varchar(20))
RETURNs INT
AS
BEGIN
DECLARE @result INT , @temp INT
SELECT @temp = count(*) from HostRequest h inner join ClubRepresentative cr on cr.id = h.Club_Representative_ID inner join club c on c.id = cr.club_ID inner join 
StadiumManger sm on sm.id = h.ST_Manger_ID inner join stadium s on s.id = sm.stadium_ID where c.name = @clubname and s.name = @stadiumname
if @temp > 0 
set @result = 1 
ELSE 
set @result = 0
RETURN @result
END

GO
create FUNCTION check_tickets(@clubhostname varchar(20), @clubguestname varchar(20),@starttime datetime)
RETURNs INT
AS
BEGIN
DECLARE @result INT , @temp INT
SELECT @temp = count(*) from ticket t inner join match m on t.match_id = m.id inner join club c on c.id = m.Club_Host_ID inner join 
club c2 on m.Club_Guest_ID = c2.id  where
c.id <> c2.id and c.name = @clubhostname and c2.name = @clubguestname and m.StarTtime = @starttime and t.status = '1'
if @temp > 0 
set @result = 1 
ELSE 
set @result = 0
RETURN @result
END

GO
create FUNCTION check_fans(@nationalid varchar(20))
RETURNs INT
AS
BEGIN
DECLARE @result INT , @temp INT
SELECT @temp = count(*) from fans f where f.national_id = @nationalid and f.status = '1'
if @temp > 0 
set @result = 1 
ELSE 
set @result = 0
RETURN @result
END

GO
create FUNCTION check_fans2(@nationalid varchar(20))
RETURNs INT
AS
BEGIN
DECLARE @result INT , @temp INT
SELECT @temp = count(*) from fans f where f.national_id = @nationalid
if @temp > 0 
set @result = 1 
ELSE 
set @result = 0
RETURN @result
END
go 

create proc DeleteMatch 
@HostName varchar(20), 
@GuestName varchar(20),
@StartTime datetime , 
@EndTime datetime 
as
delete from HostRequest where Match_id=(select id from match where (Club_Host_ID=(select id from club where name =@HostName)) AND (Club_Guest_ID=(select id from club where name=@GuestName)) )
delete from match where Club_Host_ID=(select id from club where name =@HostName) AND Club_Guest_ID=(select id from club where name =@GuestName ) AND StartTime=@StartTime AND EndTime=@EndTime
go




create function xx(@nn varchar (20))
RETURNS INT 
as
BEGIN 
DECLARE @c int 
select @c=count(*) FROM fans where National_id=@nn
RETURN @c
END 
GO 









