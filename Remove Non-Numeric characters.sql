--------  ##  Removing non numeric characters from a column
---- #### we use two mthods to remove non numeric characters . they are TRANSLATE & PADINDEX

------- ##### Mthod 1

Declare @TRANSLATE_Output  Varchar(100)

---- replace every char to  /
Set @TRANSLATE_Output = 
TRANSLATE('ABCDE#123#', 'abcdefghijklmnopqrstuvwxyz+()-,#+$%^?', '/////////////////////////////////////') 

-- replace /  to '' and so  non numeric data will be removed
Select REPLACE(@TRANSLATE_Output , '/','') As RemoveNonNumeric 

---------######


-------#####  Method 2

CREATE FUNCTION FN_RemoveNonNumeric (@InputStr NVARCHAR(500))
RETURNS NVARCHAR(500)
AS
BEGIN

WHILE PATINDEX('%[^0-9]%', @InputStr) > 0
    Set @InputStr = REPLACE(@InputStr, SUBSTRING(@InputStr, PATINDEX('%[^0-9]%', @InputStr), 1), '')

RETURN @InputStr
END

GO

------- ### Checking FN_RemoveNonNumeric Function
SELECT dbo.FN_RemoveNonNumeric('ABCDE# 123')
select dbo.FN_RemoveNonNumeric('24aisdfhoiqwei3523df45234@#$%^$@345345%^@#$^')  
Select dbo.FN_RemoveNonNumeric('ert@12aisdfhoei3456@$^$@78910%@#$^11') 

