âU
wD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Controllers\AuthenticateController.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
Controllers! ,
{ 
[ 
ApiController 
] 
[ 
Route 

(
 
$str 
) 
] 
public 

class "
AuthenticateController '
:( )
ControllerBase* 8
{8 9
private 
readonly 
IStudentsRepository ,
studentRepository- >
;> ?
private 
readonly  
IProfessorRepository -
professorRepository. A
;A B
private 
readonly 
IConfiguration '
Configuration( 5
;5 6
public "
AuthenticateController %
(% &
IStudentsRepository& 9
studentRepository: K
,K L 
IProfessorRepositoryM a
professorRepositoryb u
,u v
IConfiguration	w Ö
configuration
Ü ì
)
ì î
{
î ï
this 
. 
studentRepository "
=# $
studentRepository% 6
;6 7
this 
. 
professorRepository $
=% &
professorRepository' :
;: ;
this 
. 
Configuration 
=  
configuration! .
;. /
} 	
[   	
AllowAnonymous  	 
]   
[!! 	
HttpPost!!	 
]!! 
["" 	
Route""	 
("" 
$str"" 
)"" 
]"" 
public## 
async## 
Task## 
<## 
ActionResult## &
<##& '
object##' -
>##- .
>##. /
AuthenticateStudent##0 C
(##C D
AuthStudentDTO##D R
authStudentDTO##S a
)##a b
{##b c
var$$ 
student$$ 
=$$ 
await$$ 
studentRepository$$  1
.$$1 2
GetStudentAsync$$2 A
($$A B
authStudentDTO$$B P
.$$P Q
CNP$$Q T
)$$T U
;$$U V
if&& 
(&& 
student&& 
is&& 
null&& 
)&&  
{&&  !
return'' 
Unauthorized'' #
(''# $
new''$ '
{''( )
message'') 0
=''1 2
$str''3 L
}''L M
)''M N
;''N O
}(( 
if** 
(** 
!** 
CryptoHelper** 
.** 
comparePasswords** -
(**- .
authStudentDTO**. <
.**< =
Password**= E
,**E F
student**G N
.**N O
Password**O W
)**W X
)**X Y
{**Y Z
return++ 
Unauthorized++ #
(++# $
new++$ '
{++( )
message++) 0
=++1 2
$str++3 L
}++L M
)++M N
;++N O
},, 
var.. 
claims.. 
=.. 
new.. 
List.. !
<..! "
Claim.." '
>..' (
(..( )
)..) *
;..* +
claims// 
.// 
Add// 
(// 
new// 
Claim//  
(//  !
$str//! %
,//% &
student//' .
.//. /
Id/// 1
.//1 2
ToString//2 :
(//: ;
)//; <
)//< =
)//= >
;//> ?
claims00 
.00 
Add00 
(00 
new00 
Claim00  
(00  !

ClaimTypes00! +
.00+ ,
Role00, 0
,000 1
$str002 ;
)00; <
)00< =
;00= >
var22 
token22 
=22 
	JwtHelper22 !
.22! "
GetJwtToken22" -
(22- .
student33 
.33 
Id33 
.33 
ToString33 #
(33# $
)33$ %
,33% &
Configuration44 
[44 
$str44 '
]44' (
,44( )
Configuration55 
[55 
$str55 *
]55* +
,55+ ,
Configuration66 
[66 
$str66 *
]66* +
,66+ ,
$num77 
,77 
claims88 
.88 
ToArray88 
(88 
)88  
)88  !
;88! "
return:: 
new:: 
{;; 
token<< 
=<< 
new<< #
JwtSecurityTokenHandler<< 3
(<<3 4
)<<4 5
.<<5 6

WriteToken<<6 @
(<<@ A
token<<A F
)<<F G
,<<G H
expires== 
=== 
token== 
.==  
ValidTo==  '
}>> 
;>> 
}@@ 	
[BB 	
AllowAnonymousBB	 
]BB 
[CC 	
HttpPostCC	 
]CC 
[DD 	
RouteDD	 
(DD 
$strDD 
)DD 
]DD 
publicEE 
asyncEE 
TaskEE 
<EE 
ActionResultEE &
<EE& '
objectEE' -
>EE- .
>EE. /!
AuthenticateProfessorEE0 E
(EEE F
AuthProfessorDTOEEF V
authProfessorDTOEEW g
)EEg h
{EEh i
varFF 

proffessorFF 
=FF 
awaitFF "
professorRepositoryFF# 6
.FF6 7
GetProfessorAsyncFF7 H
(FFH I
authProfessorDTOFFI Y
.FFY Z
nameFFZ ^
)FF^ _
;FF_ `
ifHH 
(HH 

proffessorHH 
isHH 
nullHH "
)HH" #
{HH# $
returnII 
UnauthorizedII #
(II# $
newII$ '
{II( )
messageII) 0
=II1 2
$strII3 E
}IIE F
)IIF G
;IIG H
}JJ 
ifLL 
(LL 
!LL 
CryptoHelperLL 
.LL 
comparePasswordsLL -
(LL- .
authProfessorDTOLL. >
.LL> ?
PasswordLL? G
,LLG H

proffessorLLI S
.LLS T
PasswordLLT \
)LL\ ]
)LL] ^
{LL^ _
returnMM 
UnauthorizedMM #
(MM# $
newMM$ '
{MM( )
messageMM) 0
=MM1 2
$strMM3 E
}MME F
)MMF G
;MMG H
}NN 
varPP 
claimsPP 
=PP 
newPP 
ListPP !
<PP! "
ClaimPP" '
>PP' (
(PP( )
)PP) *
;PP* +
claimsQQ 
.QQ 
AddQQ 
(QQ 
newQQ 
ClaimQQ  
(QQ  !
$strQQ! %
,QQ% &

proffessorQQ' 1
.QQ1 2
IdQQ2 4
.QQ4 5
ToStringQQ5 =
(QQ= >
)QQ> ?
)QQ? @
)QQ@ A
;QQA B
claimsRR 
.RR 
AddRR 
(RR 
newRR 
ClaimRR  
(RR  !

ClaimTypesRR! +
.RR+ ,
RoleRR, 0
,RR0 1
$strRR2 =
)RR= >
)RR> ?
;RR? @
varTT 
tokenTT 
=TT 
	JwtHelperTT !
.TT! "
GetJwtTokenTT" -
(TT- .

proffessorUU 
.UU 
IdUU 
.UU 
ToStringUU &
(UU& '
)UU' (
,UU( )
ConfigurationVV 
[VV 
$strVV '
]VV' (
,VV( )
ConfigurationWW 
[WW 
$strWW *
]WW* +
,WW+ ,
ConfigurationXX 
[XX 
$strXX *
]XX* +
,XX+ ,
$numYY 
,YY 
claimsZZ 
.ZZ 
ToArrayZZ 
(ZZ 
)ZZ  
)ZZ  !
;ZZ! "
return\\ 
new\\ 
{]] 
token^^ 
=^^ 
new^^ #
JwtSecurityTokenHandler^^ 3
(^^3 4
)^^4 5
.^^5 6

WriteToken^^6 @
(^^@ A
token^^A F
)^^F G
,^^G H
expires__ 
=__ 
token__ 
.__  
ValidTo__  '
}`` 
;`` 
}bb 	
[dd 	
AllowAnonymousdd	 
]dd 
[ee 	
HttpPostee	 
]ee 
[ff 	
Routeff	 
(ff 
$strff 
)ff 
]ff 
publicgg 
ActionResultgg 
<gg 
objectgg "
>gg" #
AuthenticateAdmingg$ 5
(gg5 6
AuthAdminDTOgg6 B
authAdminDTOggC O
)ggO P
{ggP Q
ifii 
(ii 
authAdminDTOii 
.ii 
nameii  
!=ii! #
$strii$ +
||ii, .
authAdminDTOii/ ;
.ii; <
Passwordii< D
!=iiE G
$striiH O
)iiO P
{iiP Q
returnjj 
Unauthorizedjj #
(jj# $
newjj$ '
{jj( )
messagejj) 0
=jj1 2
$strjj3 Q
}jjQ R
)jjR S
;jjS T
}kk 
varmm 
claimsmm 
=mm 
newmm 
Listmm !
<mm! "
Claimmm" '
>mm' (
(mm( )
)mm) *
;mm* +
claimsnn 
.nn 
Addnn 
(nn 
newnn 
Claimnn  
(nn  !

ClaimTypesnn! +
.nn+ ,
Rolenn, 0
,nn0 1
$strnn2 9
)nn9 :
)nn: ;
;nn; <
varpp 
tokenpp 
=pp 
	JwtHelperpp !
.pp! "
GetJwtTokenpp" -
(pp- .
$strqq 
,qq 
Configurationrr 
[rr 
$strrr '
]rr' (
,rr( )
Configurationss 
[ss 
$strss *
]ss* +
,ss+ ,
Configurationtt 
[tt 
$strtt *
]tt* +
,tt+ ,
$numuu 
,uu 
claimsvv 
.vv 
ToArrayvv 
(vv 
)vv  
)vv  !
;vv! "
returnxx 
newxx 
{yy 
tokenzz 
=zz 
newzz #
JwtSecurityTokenHandlerzz 3
(zz3 4
)zz4 5
.zz5 6

WriteTokenzz6 @
(zz@ A
tokenzzA F
)zzF G
,zzG H
expires{{ 
={{ 
token{{ 
.{{  
ValidTo{{  '
}|| 
;|| 
}~~ 	
}
ÅÅ 
}ÉÉ Ãu
tD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Controllers\ProfessorController.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
Controllers! ,
{ 
[ 
ApiController 
] 
[ 
Route 

(
 
$str 
) 
] 
public 

class 
ProfessorController $
:% &
ControllerBase' 5
{5 6
private 
readonly  
IProfessorRepository -
professorRepository. A
;A B
private 
readonly 
ISubjectsRepository ,
subjectsRepository- ?
;? @
public 
ProfessorController "
(" # 
IProfessorRepository# 7

repository8 B
,B C
ISubjectsRepositoryD W
subjectsRepositoryX j
)j k
{k l
this 
. 
professorRepository $
=% &

repository' 1
;1 2
this 
. 
subjectsRepository #
=$ %
subjectsRepository& 8
;8 9
} 	
[ 	
	Authorize	 
( 
Roles 
= 
$str "
)" #
]# $
[ 	
HttpGet	 
] 
public 
async 
Task 
< 
IEnumerable %
<% &
ProfessorDataDTO& 6
>6 7
>7 8
GetProfessors9 F
(F G
)G H
{H I
List 
< 
ProfessorDataDTO !
>! "
professorDataDTOs# 4
=5 6
new7 :
List; ?
<? @
ProfessorDataDTO@ P
>P Q
(Q R
)R S
;S T
var   
profs   
=   
(   
await   
professorRepository   2
.  2 3
GetProfessorsAsync  3 E
(  E F
)  F G
)  G H
;  H I
foreach"" 
("" 
	Professor"" 
prof"" #
in""$ &
profs""' ,
)"", -
{## 
Subject$$ 
subject$$ 
=$$  !
await$$" '
subjectsRepository$$( :
.$$: ;
GetSubjectAsync$$; J
($$J K
prof$$K O
.$$O P
Subject$$P W
)$$W X
;$$X Y
professorDataDTOs%% !
.%%! "
Add%%" %
(%%% &
prof%%& *
.%%* +
	AsDataDto%%+ 4
(%%4 5
subject%%5 <
.%%< =
Title%%= B
)%%B C
)%%C D
;%%D E
}&& 
return(( 
professorDataDTOs(( $
;(($ %
})) 	
[++ 	
HttpGet++	 
(++ 
$str++ 
)++ 
]++ 
public,, 
async,, 
Task,, 
<,, 
ActionResult,, &
<,,& '
ProfessorDataDTO,,' 7
>,,7 8
>,,8 9
GetProfessor,,: F
(,,F G
string,,G M
id,,N P
),,P Q
{,,Q R
	Professor-- 
	professor-- 
=--  !
await--" '
professorRepository--( ;
.--; <
GetProfessorAsync--< M
(--M N
Guid--N R
.--R S
Parse--S X
(--X Y
User--Y ]
.--] ^
Claims--^ d
.--d e
FirstOrDefault--e s
(--s t
a--t u
=>--v x
a--y z
.--z {
Type--{ 
==
--Ä Ç
$str
--É á
)
--á à
.
--à â
Value
--â é
)
--é è
)
--è ê
;
--ê ë
if// 
(// 
	professor// 
==// 
null//  
)//  !
{//! "
	professor00 
=00 
(00 
await00 "
professorRepository00# 6
.006 7
GetProfessorAsync007 H
(00H I
Guid00I M
.00M N
Parse00N S
(00S T
id00T V
)00V W
)00W X
)00X Y
;00Y Z
if11 
(11 
	professor11 
==11 
null11  $
)11$ %
{11% &
return22 
NotFound22 #
(22# $
new22$ '
{22( )
message33 
=33  !
$str33" ;
,33; <
}44 
)44 
;44 
}55 
string66 
subject66 
=66  
(66! "
await66" '
subjectsRepository66( :
.66: ;
GetSubjectAsync66; J
(66J K
	professor66K T
.66T U
Subject66U \
)66\ ]
)66] ^
.66^ _
Title66_ d
;66d e
return77 
	professor77  
.77  !
	AsDataDto77! *
(77* +
subject77+ 2
)772 3
;773 4
}88 
else88 
{88 
string99 
subject99 
=99  
(99! "
await99" '
subjectsRepository99( :
.99: ;
GetSubjectAsync99; J
(99J K
	professor99K T
.99T U
Subject99U \
)99\ ]
)99] ^
.99^ _
Title99_ d
;99d e
return:: 
(:: 
	professor:: !
.::! "
	AsDataDto::" +
(::+ ,
subject::, 3
)::3 4
)::4 5
;::5 6
};; 
}<< 	
[?? 	
	Authorize??	 
(?? 
Roles?? 
=?? 
$str?? "
)??" #
]??# $
[@@ 	
HttpPost@@	 
]@@ 
[AA 	
RouteAA	 
(AA 
$strAA 
)AA 
]AA 
publicBB 
asyncBB 
TaskBB 
<BB 
IEnumerableBB %
<BB% &$
NewlyCreatedProfessorDTOBB& >
>BB> ?
>BB? @
CreateProfessorsBBA Q
(BBQ R
ListBBR V
<BBV W
CreateProfessorDTOBBW i
>BBi j
professorsDTOBBk x
)BBx y
{BBy z
ListCC 
<CC $
NewlyCreatedProfessorDTOCC )
>CC) *%
newlyCreatedProfessorDTOsCC+ D
=CCE F
newCCG J
ListCCK O
<CCO P$
NewlyCreatedProfessorDTOCCP h
>CCh i
(CCi j
)CCj k
;CCk l
foreachEE 
(EE 
CreateProfessorDTOEE &
professorDTOEE' 3
inEE4 6
professorsDTOEE7 D
)EED E
{EEE F
SubjectFF 
subjectFF 
=FF  !
awaitFF" '
subjectsRepositoryFF( :
.FF: ;
GetSubjectAsyncFF; J
(FFJ K
professorDTOFFK W
.FFW X
SubjectFFX _
)FF_ `
;FF` a
ifHH 
(HH 
subjectHH 
==HH 
nullHH "
)HH" #
{HH# $
subjectII 
=II 
newII !
SubjectII" )
(II) *
)II* +
{II+ ,
IdJJ 
=JJ 
GuidJJ !
.JJ! "
NewGuidJJ" )
(JJ) *
)JJ* +
,JJ+ ,
TitleKK 
=KK 
professorDTOKK  ,
.KK, -
SubjectKK- 4
}LL 
;LL 
awaitNN 
subjectsRepositoryNN ,
.NN, -
CreateSubjectAsyncNN- ?
(NN? @
subjectNN@ G
)NNG H
;NNH I
}OO 
GuidQQ 
idQQ 
=QQ 
GuidQQ 
.QQ 
NewGuidQQ &
(QQ& '
)QQ' (
;QQ( )
stringRR 
passwordRR 
=RR  !
RandomHelperRR" .
.RR. / 
GenerateRandomStringRR/ C
(RRC D
$numRRD F
)RRF G
;RRG H
stringSS 
hashedPasswordSS %
=SS& '
CryptoHelperSS( 4
.SS4 5
hashPasswordSS5 A
(SSA B
passwordSSB J
)SSJ K
;SSK L%
newlyCreatedProfessorDTOsUU )
.UU) *
AddUU* -
(UU- .
newUU. 1
(UU1 2
)UU2 3
{UU3 4
IdVV 
=VV 
idVV 
,VV 
LastNameWW 
=WW 
professorDTOWW +
.WW+ ,
LastNameWW, 4
,WW4 5
	FirstNameXX 
=XX 
professorDTOXX  ,
.XX, -
	FirstNameXX- 6
,XX6 7
usernameYY 
=YY 
professorDTOYY +
.YY+ ,
	FirstNameYY, 5
.YY5 6
ToLowerYY6 =
(YY= >
)YY> ?
+YY@ A
$strYYB E
+YYF G
professorDTOYYH T
.YYT U
LastNameYYU ]
.YY] ^
ToLowerYY^ e
(YYe f
)YYf g
,YYg h
SubjectZZ 
=ZZ 
subjectZZ %
.ZZ% &
TitleZZ& +
,ZZ+ ,
Password[[ 
=[[ 
password[[ '
}\\ 
)\\ 
;\\ 
	Professor^^ 
	professor^^ #
=^^$ %
new^^& )
	Professor^^* 3
(^^3 4
)^^4 5
{^^5 6
Id__ 
=__ 
id__ 
,__ 
LastName`` 
=`` 
professorDTO`` +
.``+ ,
LastName``, 4
,``4 5
	FirstNameaa 
=aa 
professorDTOaa  ,
.aa, -
	FirstNameaa- 6
,aa6 7
usernamebb 
=bb 
professorDTObb +
.bb+ ,
	FirstNamebb, 5
.bb5 6
ToLowerbb6 =
(bb= >
)bb> ?
+bb@ A
$strbbB E
+bbF G
professorDTObbH T
.bbT U
LastNamebbU ]
.bb] ^
ToLowerbb^ e
(bbe f
)bbf g
,bbg h
Subjectcc 
=cc 
subjectcc %
.cc% &
Idcc& (
,cc( )
Passworddd 
=dd 
hashedPassworddd -
}ee 
;ee 
awaitgg 
professorRepositorygg )
.gg) * 
CreateProfessorAsyncgg* >
(gg> ?
	professorgg? H
)ggH I
;ggI J
}hh 
returnjj %
newlyCreatedProfessorDTOsjj ,
;jj, -
}kk 	
[nn 	
	Authorizenn	 
(nn 
Rolesnn 
=nn 
$strnn "
)nn" #
]nn# $
[oo 	
HttpPutoo	 
(oo 
$stroo 
)oo 
]oo 
publicpp 
asyncpp 
Taskpp 
<pp 
ActionResultpp &
>pp& ' 
UpdateProfessorAsyncpp( <
(pp< =
Guidpp= A
idppB D
,ppD E
UpdateProfessorDTOppF X
professorDTOppY e
)ppe f
{ppf g
varqq 
existingItemqq 
=qq 
awaitqq $
professorRepositoryqq% 8
.qq8 9
GetProfessorAsyncqq9 J
(qqJ K
idqqK M
)qqM N
;qqN O
ifss 
(ss 
existingItemss 
isss 
nullss #
)ss# $
{ss$ %
returntt 
NotFoundtt 
(tt  
)tt  !
;tt! "
}uu 
Subjectww 
subjectww 
=ww 
awaitww #
subjectsRepositoryww$ 6
.ww6 7
GetSubjectAsyncww7 F
(wwF G
professorDTOwwG S
.wwS T
SubjectwwT [
)ww[ \
;ww\ ]
ifyy 
(yy 
subjectyy 
==yy 
nullyy 
)yy 
{yy  
subjectzz 
=zz 
newzz 
Subjectzz %
(zz% &
)zz& '
{zz' (
Id{{ 
={{ 
Guid{{ 
.{{ 
NewGuid{{ %
({{% &
){{& '
,{{' (
Title|| 
=|| 
professorDTO|| (
.||( )
Subject||) 0
}}} 
;}} 
await 
subjectsRepository (
.( )
CreateSubjectAsync) ;
(; <
subject< C
)C D
;D E
}
ÄÄ 
	Professor
ÇÇ 
updatedProffesor
ÇÇ &
=
ÇÇ' (
existingItem
ÇÇ) 5
with
ÇÇ6 :
{
ÇÇ; <
	FirstName
ÉÉ 
=
ÉÉ 
professorDTO
ÉÉ (
.
ÉÉ( )
	FirstName
ÉÉ) 2
,
ÉÉ2 3
LastName
ÑÑ 
=
ÑÑ 
professorDTO
ÑÑ '
.
ÑÑ' (
LastName
ÑÑ( 0
,
ÑÑ0 1
username
ÖÖ 
=
ÖÖ 
professorDTO
ÖÖ '
.
ÖÖ' (
	FirstName
ÖÖ( 1
.
ÖÖ1 2
ToLower
ÖÖ2 9
(
ÖÖ9 :
)
ÖÖ: ;
+
ÖÖ< =
$str
ÖÖ> A
+
ÖÖB C
professorDTO
ÖÖD P
.
ÖÖP Q
LastName
ÖÖQ Y
.
ÖÖY Z
ToLower
ÖÖZ a
(
ÖÖa b
)
ÖÖb c
,
ÖÖc d
Subject
ÜÜ 
=
ÜÜ 
subject
ÜÜ !
.
ÜÜ! "
Id
ÜÜ" $
,
ÜÜ$ %
}
áá 
;
áá 
await
ââ !
professorRepository
ââ %
.
ââ% &"
UpdateProfessorAsync
ââ& :
(
ââ: ;
updatedProffesor
ââ; K
)
ââK L
;
ââL M
return
ãã 
	NoContent
ãã 
(
ãã 
)
ãã 
;
ãã 
}
åå 	
[
éé 	
	Authorize
éé	 
(
éé 
Roles
éé 
=
éé 
$str
éé "
)
éé" #
]
éé# $
[
èè 	

HttpDelete
èè	 
(
èè 
$str
èè 
)
èè 
]
èè 
public
êê 
async
êê 
Task
êê 
<
êê 
ActionResult
êê &
>
êê& '
DeleteProfessor
êê( 7
(
êê7 8
Guid
êê8 <
id
êê= ?
)
êê? @
{
êê@ A
var
ëë 
existingItem
ëë 
=
ëë 
await
ëë $!
professorRepository
ëë% 8
.
ëë8 9
GetProfessorAsync
ëë9 J
(
ëëJ K
id
ëëK M
)
ëëM N
;
ëëN O
if
ìì 
(
ìì 
existingItem
ìì 
is
ìì 
null
ìì #
)
ìì# $
{
ìì$ %
return
îî 
NotFound
îî 
(
îî  
)
îî  !
;
îî! "
}
ïï !
professorRepository
óó 
.
óó  "
DeleteProfessorAsync
óó  4
(
óó4 5
existingItem
óó5 A
.
óóA B
Id
óóB D
)
óóD E
;
óóE F
return
ôô 
	NoContent
ôô 
(
ôô 
)
ôô 
;
ôô 
}
öö 	
}
õõ 
}úú ÙF
yD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Controllers\StudentAbsencesCotroller.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
Controllers! ,
{ 
[ 
ApiController 
] 
[ 
Route 

(
 
$str 
) 
]  
public 

class %
StudentAbsencesController *
:+ ,
ControllerBase- ;
{; <
private 
readonly 
IStudentsRepository ,
studentsRepository- ?
;? @
private 
readonly  
IProfessorRepository - 
professorsRepository. B
;B C
private 
readonly 
IAbsensesRepository ,
absensesRepository- ?
;? @
public %
StudentAbsencesController (
(( )
IStudentsRepository) <
studentsRepository= O
,O P 
IProfessorRepositoryQ e
professorRepositoryf y
,y z 
IAbsensesRepository	{ é 
absensesRepository
è °
)
° ¢
{
¢ £
this 
. 
studentsRepository #
=$ %
studentsRepository& 8
;8 9
this 
.  
professorsRepository %
=& '
professorRepository( ;
;; <
this 
. 
absensesRepository #
=$ %
absensesRepository& 8
;8 9
} 	
[ 	
	Authorize	 
( 
Roles 
= 
$str &
)& '
]' (
[   	
HttpGet  	 
(   
$str   
)   
]   
public!! 
async!! 
Task!! 
<!! 
IEnumerable!! %
<!!% &

AbsenceDTO!!& 0
>!!0 1
>!!1 2#
GetStudentAbsencesAsync!!3 J
(!!J K
Guid!!K O
id!!P R
)!!R S
{!!S T
var"" 
absences"" 
="" 
("" 
await"" !
absensesRepository""" 4
.""4 5#
GetAbsencesStudentAsync""5 L
(""L M
id""M O
)""O P
)""P Q
.""Q R
Select""R X
(""X Y
abs""Y \
=>""] _
abs""` c
.""c d
AsDto""d i
(""i j
)""j k
)""k l
;""l m
return$$ 
absences$$ 
;$$ 
}%% 	
[(( 	
	Authorize((	 
((( 
Roles(( 
=(( 
$str(( &
)((& '
]((' (
[)) 	
HttpPost))	 
])) 
public** 
async** 
Task** 
<** 
ActionResult** &
<**& '
Absence**' .
>**. /
>**/ 0

AddAbsence**1 ;
(**; <
CreateAbsenceDTO**< L
createAbsenceDTO**M ]
)**] ^
{**^ _
	Professor,, 
	professor,, 
=,,  !
await,," ' 
professorsRepository,,( <
.,,< =
GetProfessorAsync,,= N
(,,N O
Guid,,O S
.,,S T
Parse,,T Y
(,,Y Z
User,,Z ^
.,,^ _
Claims,,_ e
.,,e f
FirstOrDefault,,f t
(,,t u
a,,u v
=>,,w y
a,,z {
.,,{ |
Type	,,| Ä
==
,,Å É
$str
,,Ñ à
)
,,à â
.
,,â ä
Value
,,ä è
)
,,è ê
)
,,ê ë
;
,,ë í
Student-- 
existingStudent-- #
=--$ %
await--& +
studentsRepository--, >
.--> ?
GetStudentAsync--? N
(--N O
createAbsenceDTO--O _
.--_ `
Student--` g
)--g h
;--h i
if// 
(// 
existingStudent// 
==// !
null//" &
)//& '
{//' (
return00 
NotFound00 
(00  
new00  #
{00$ %
message11 
=11 
$str11 1
+112 3
createAbsenceDTO114 D
.11D E
Student11E L
+11M N
$str11O [
}22 
)22 
;22 
}33 
List55 
<55 
Guid55 
>55 
existingAbsences55 '
=55( )
new55* -
List55. 2
<552 3
Guid553 7
>557 8
(558 9
existingStudent559 H
.55H I
Absences55I Q
)55Q R
;55R S
Absence77 
absence77 
=77 
new77 !
(77! "
)77" #
{77# $
Id88 
=88 
Guid88 
.88 
NewGuid88 !
(88! "
)88" #
,88# $
Student99 
=99 
createAbsenceDTO99 *
.99* +
Student99+ 2
,992 3
Subject:: 
=:: 
	professor:: #
.::# $
Subject::$ +
,::+ ,
Date;; 
=;; 
createAbsenceDTO;; '
.;;' (
Date;;( ,
,;;, -

motivation<< 
=<< 
$str<< 
,<<  
excused== 
=== 
false== 
}>> 
;>> 
existingAbsences@@ 
.@@ 
Add@@  
(@@  !
absence@@! (
.@@( )
Id@@) +
)@@+ ,
;@@, -
awaitCC 
absensesRepositoryCC $
.CC$ %
CreateAbsenceAsyncCC% 7
(CC7 8
absenceCC8 ?
)CC? @
;CC@ A
awaitFF 
studentsRepositoryFF $
.FF$ %
UpdateStudentAsyncFF% 7
(FF7 8
newFF8 ;
StudentFF< C
{FFC D
IdGG 
=GG 
existingStudentGG $
.GG$ %
IdGG% '
,GG' (
LastNameHH 
=HH 
existingStudentHH *
.HH* +
LastNameHH+ 3
,HH3 4
	FirstNameII 
=II 
existingStudentII +
.II+ ,
	FirstNameII, 5
,II5 6
CNPJJ 
=JJ 
existingStudentJJ %
.JJ% &
CNPJJ& )
,JJ) *
PasswordKK 
=KK 
existingStudentKK *
.KK* +
PasswordKK+ 3
,KK3 4
GradesLL 
=LL 
existingStudentLL (
.LL( )
GradesLL) /
,LL/ 0
AbsencesMM 
=MM 
existingAbsencesMM +
.MM+ ,
ToArrayMM, 3
(MM3 4
)MM4 5
,MM5 6
AssignmentsNN 
=NN 
existingStudentNN -
.NN- .
AssignmentsNN. 9
}OO 
)OO 
;OO 
returnQQ 
CreatedQQ 
(QQ 
$strQQ &
,QQ& '
absenceQQ( /
)QQ/ 0
;QQ0 1
}RR 	
[TT 	
HttpPutTT	 
(TT 
$strTT 
)TT 
]TT 
publicUU 
asyncUU 
TaskUU 
<UU 
ActionResultUU &
>UU& '%
UpdateStudentAbsenceAsyncUU( A
(UUA B
GuidUUB F
idUUG I
,UUI J
UpdateAbsenceDTOUUK [
updateAbsenceDTOUU\ l
)UUl m
{UUm n
varVV 
existingItemVV 
=VV 
awaitVV $
absensesRepositoryVV% 7
.VV7 8

GetAbsenceVV8 B
(VVB C
idVVC E
)VVE F
;VVF G
ifXX 
(XX 
existingItemXX 
isXX 
nullXX #
)XX# $
{XX$ %
returnYY 
NotFoundYY 
(YY  
)YY  !
;YY! "
}ZZ 
Absence\\ 
updatedAbsence\\ "
=\\# $
existingItem\\% 1
with\\2 6
{\\7 8
Id]] 
=]] 
existingItem]] !
.]]! "
Id]]" $
,]]$ %
Student^^ 
=^^ 
existingItem^^ &
.^^& '
Student^^' .
,^^. /
Subject__ 
=__ 
existingItem__ &
.__& '
Subject__' .
,__. /
excused`` 
=`` 
updateAbsenceDTO`` *
.``* +
excused``+ 2
,``2 3

motivationaa 
=aa 
updateAbsenceDTOaa -
.aa- .

motivationaa. 8
,aa8 9
Datebb 
=bb 
existingItembb #
.bb# $
Datebb$ (
}cc 
;cc 
awaitee 
absensesRepositoryee $
.ee$ %
UpdateAbsenceAsyncee% 7
(ee7 8
updatedAbsenceee8 F
)eeF G
;eeG H
returngg 
	NoContentgg 
(gg 
)gg 
;gg 
}hh 	
}jj 
}kk ˛E
}D:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Controllers\StudentAssignmentsController.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
Controllers! ,
{ 
[ 
ApiController 
] 
[ 
Route 

(
 
$str !
)! "
]" #
public 

class (
StudentAssignmentsController -
:. /
ControllerBase0 >
{> ?
private 
readonly 
IStudentsRepository ,
studentsRepository- ?
;? @
private 
readonly  
IProfessorRepository - 
professorsRepository. B
;B C
private 
readonly "
IAssignmentsRepository /!
assignmentsRepository0 E
;E F
public (
StudentAssignmentsController +
(+ ,
IStudentsRepository, ?
studentsRepository@ R
,R S 
IProfessorRepositoryT h
professorRepositoryi |
,| }#
IAssignmentsRepository	~ î#
assignmentsRepository
ï ™
)
™ ´
{
´ ¨
this 
. 
studentsRepository #
=$ %
studentsRepository& 8
;8 9
this 
.  
professorsRepository %
=& '
professorRepository( ;
;; <
this 
. !
assignmentsRepository &
=' (!
assignmentsRepository) >
;> ?
} 	
[   	
	Authorize  	 
(   
Roles   
=   
$str   &
)  & '
]  ' (
[!! 	
HttpGet!!	 
(!! 
$str!! 
)!! 
]!! 
public"" 
async"" 
Task"" 
<"" 
IEnumerable"" %
<""% &
AssignmentDTO""& 3
>""3 4
>""4 5&
GetStudentAssignmentsAsync""6 P
(""P Q
Guid""Q U
id""V X
)""X Y
{""Y Z
var## 
assignments## 
=## 
(## 
await## $!
assignmentsRepository##% :
.##: ;&
GetAssignmentsStudentAsync##; U
(##U V
id##V X
)##X Y
)##Y Z
.##Z [
Select##[ a
(##a b
abs##b e
=>##f h
abs##i l
.##l m
AsDto##m r
(##r s
)##s t
)##t u
;##u v
return%% 
assignments%% 
;%% 
}&& 	
[)) 	
	Authorize))	 
()) 
Roles)) 
=)) 
$str)) &
)))& '
]))' (
[** 	
HttpPost**	 
]** 
public++ 
async++ 
Task++ 
<++ 
ActionResult++ &
<++& '

StudentDTO++' 1
>++1 2
>++2 3
AddAssignment++4 A
(++A B
CreateAssignmentDTO++B U
createAssignmentDTO++V i
)++i j
{++j k
	Professor-- 
	professor-- 
=--  !
await--" ' 
professorsRepository--( <
.--< =
GetProfessorAsync--= N
(--N O
Guid--O S
.--S T
Parse--T Y
(--Y Z
User--Z ^
.--^ _
Claims--_ e
.--e f
FirstOrDefault--f t
(--t u
a--u v
=>--w y
a--z {
.--{ |
Type	--| Ä
==
--Å É
$str
--Ñ à
)
--à â
.
--â ä
Value
--ä è
)
--è ê
)
--ê ë
;
--ë í
Student.. 
existingStudent.. #
=..$ %
await..& +
studentsRepository.., >
...> ?
GetStudentAsync..? N
(..N O
createAssignmentDTO..O b
...b c
Student..c j
)..j k
;..k l
if00 
(00 
existingStudent00 
==00 !
null00" &
)00& '
{00' (
return11 
NotFound11 
(11  
new11  #
{11$ %
message22 
=22 
$str22 1
+222 3
createAssignmentDTO224 G
.22G H
Student22H O
+22P Q
$str22R ^
}33 
)33 
;33 
}44 
List66 
<66 
Guid66 
>66 
existingAssignments66 *
=66+ ,
new66- 0
List661 5
<665 6
Guid666 :
>66: ;
(66; <
existingStudent66< K
.66K L
Assignments66L W
)66W X
;66X Y

Assignment88 

assignment88 !
=88" #
new88$ '
(88' (
)88( )
{88) *
Id99 
=99 
Guid99 
.99 
NewGuid99 !
(99! "
)99" #
,99# $
Student:: 
=:: 
createAssignmentDTO:: -
.::- .
Student::. 5
,::5 6
Subject;; 
=;; 
	professor;; #
.;;# $
Subject;;$ +
,;;+ ,
Done<< 
=<< 
false<< 
,<< 
DateFrom== 
=== 
createAssignmentDTO== .
.==. /
DateFrom==/ 7
,==7 8
DateDue>> 
=>> 
createAssignmentDTO>> -
.>>- .
DateDue>>. 5
}?? 
;?? 
existingAssignmentsAA 
.AA  
AddAA  #
(AA# $

assignmentAA$ .
.AA. /
IdAA/ 1
)AA1 2
;AA2 3
awaitDD !
assignmentsRepositoryDD '
.DD' (!
CreateAssignmentAsyncDD( =
(DD= >

assignmentDD> H
)DDH I
;DDI J
awaitGG 
studentsRepositoryGG $
.GG$ %
UpdateStudentAsyncGG% 7
(GG7 8
newGG8 ;
StudentGG< C
{GGC D
IdHH 
=HH 
existingStudentHH $
.HH$ %
IdHH% '
,HH' (
LastNameII 
=II 
existingStudentII *
.II* +
LastNameII+ 3
,II3 4
	FirstNameJJ 
=JJ 
existingStudentJJ +
.JJ+ ,
	FirstNameJJ, 5
,JJ5 6
CNPKK 
=KK 
existingStudentKK %
.KK% &
CNPKK& )
,KK) *
PasswordLL 
=LL 
existingStudentLL *
.LL* +
PasswordLL+ 3
,LL3 4
GradesMM 
=MM 
existingStudentMM (
.MM( )
GradesMM) /
,MM/ 0
AbsencesNN 
=NN 
existingStudentNN *
.NN* +
AbsencesNN+ 3
,NN3 4
AssignmentsOO 
=OO 
existingAssignmentsOO 1
.OO1 2
ToArrayOO2 9
(OO9 :
)OO: ;
}PP 
)PP 
;PP 
returnRR 
CreatedRR 
(RR 
$strRR )
,RR) *

assignmentRR+ 5
)RR5 6
;RR6 7
}SS 	
[UU 	
	AuthorizeUU	 
(UU 
RolesUU 
=UU 
$strUU &
)UU& '
]UU' (
[VV 	
HttpPutVV	 
(VV 
$strVV 
)VV 
]VV 
publicWW 
asyncWW 
TaskWW 
<WW 
ActionResultWW &
>WW& '(
UpdateStudentAssignmentAsyncWW( D
(WWD E
GuidWWE I
idWWJ L
,WWL M
UpdateAssignmentDTOWWN a
updateAssignmentDTOWWb u
)WWu v
{WWv w
varXX 
existingItemXX 
=XX 
awaitXX $!
assignmentsRepositoryXX% :
.XX: ;
GetAssignmentAsyncXX; M
(XXM N
idXXN P
)XXP Q
;XXQ R
ifZZ 
(ZZ 
existingItemZZ 
isZZ 
nullZZ #
)ZZ# $
{ZZ$ %
return[[ 
NotFound[[ 
([[  
)[[  !
;[[! "
}\\ 

Assignment^^ 
updatedAssignment^^ (
=^^) *
existingItem^^+ 7
with^^8 <
{^^= >
Done__ 
=__ 
updateAssignmentDTO__ *
.__* +
Done__+ /
,__/ 0
DateDue`` 
=`` 
updateAssignmentDTO`` -
.``- .
DateDue``. 5
}aa 
;aa 
awaitcc !
assignmentsRepositorycc '
.cc' ("
UpdateAssignmentsAsynccc( >
(cc> ?
updatedAssignmentcc? P
)ccP Q
;ccQ R
returnee 
	NoContentee 
(ee 
)ee 
;ee 
}ff 	
}hh 
}ii ˆ
yD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Controllers\StudentProfileController.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
Controllers! ,
{ 
[ 
ApiController 
] 
[ 
Route 

(
 
$str 
) 
] 
public 

class $
StudentProfileController )
:* +
ControllerBase, :
{: ;
private 
readonly 
IStudentsRepository ,

repository- 7
;7 8
private 
readonly 
StudentServices (
studentServices) 8
;8 9
public $
StudentProfileController '
(' (
IStudentsRepository 

repository &
,& '
IGradesRepository 
gradesRepository *
,* +
ISubjectsRepository 
subjectsRepository .
,. /
IAbsensesRepository 
absensesRepository .
,. /"
IAssignmentsRepository !
assignmentsRepository 4
)4 5
{5 6
this   
.   

repository   
=   

repository   (
;  ( )
studentServices"" 
="" 
new"" !
StudentServices""" 1
(""1 2
gradesRepository""2 B
,""B C
subjectsRepository""D V
,""V W
absensesRepository""X j
,""j k"
assignmentsRepository	""l Å
)
""Å Ç
;
""Ç É
}## 	
[%% 	
	Authorize%%	 
(%% 
Roles%% 
=%% 
$str%% $
)%%$ %
]%%% &
[&& 	
HttpGet&&	 
]&& 
public'' 
async'' 
Task'' 
<'' 
ActionResult'' &
<''& '
StudentProfileDTO''' 8
>''8 9
>''9 :
GetStudentAsync''; J
(''J K
)''K L
{''L M
var)) 
id)) 
=)) 
User)) 
.)) 
Claims))  
.))  !
FirstOrDefault))! /
())/ 0
a))0 1
=>))2 4
a))5 6
.))6 7
Type))7 ;
==))< >
$str))? C
)))C D
.))D E
Value))E J
;))J K
var++ 
student++ 
=++ 
await++ 

repository++  *
.++* +
GetStudentAsync+++ :
(++: ;
Guid++; ?
.++? @
Parse++@ E
(++E F
id++F H
)++H I
)++I J
;++J K
if-- 
(-- 
student-- 
is-- 
null-- 
)--  
{--  !
return.. 

BadRequest.. !
(..! "
new.." %
{..& '
message// 
=// 
$str	// ã
,
//ã å
}00 
)00 
;00 
}11 
return33 
await33 
studentServices33 (
.33( )
GetStudentProfile33) :
(33: ;
student33; B
)33B C
;33C D
}44 
}55 
}66 ˘N
yD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Controllers\StudentsGradesController.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
Controllers! ,
{ 
[ 
ApiController 
] 
[ 
Route 

(
 
$str 
) 
] 
public 

class $
StudentsGradesController )
:* +
ControllerBase, :
{: ;
private 
readonly 
IStudentsRepository ,
studentsRepository- ?
;? @
private 
readonly  
IProfessorRepository - 
professorsRepository. B
;B C
private 
readonly 
IGradesRepository *
gradesRepository+ ;
;; <
public $
StudentsGradesController '
(' (
IStudentsRepository( ;
studentsRepository< N
,N O 
IProfessorRepositoryP d
professorRepositorye x
,x y
IGradesRepository	z ã
gradesRepository
å ú
)
ú ù
{
ù û
this 
. 
studentsRepository #
=$ %
studentsRepository& 8
;8 9
this 
.  
professorsRepository %
=& '
professorRepository( ;
;; <
this 
. 
gradesRepository !
=" #
gradesRepository$ 4
;4 5
} 	
[ 	
	Authorize	 
( 
Roles 
= 
$str &
)& '
]' (
[ 	
HttpGet	 
] 
public 
async 
Task 
< 
IEnumerable %
<% &
GradeDTO& .
>. /
>/ 0
GetAllGradesAsync1 B
(B C
)C D
{D E
var   
grades   
=   
(   
await   
gradesRepository    0
.  0 1
GetGradesAsync  1 ?
(  ? @
)  @ A
)  A B
.!! 
Select!! #
(!!# $
grades!!$ *
=>!!+ -
grades!!. 4
.!!4 5
AsDto!!5 :
(!!: ;
)!!; <
)!!< =
;!!= >
return"" 
grades"" 
;"" 
}## 	
[%% 	
	Authorize%%	 
(%% 
Roles%% 
=%% 
$str%% &
)%%& '
]%%' (
[&& 	
HttpGet&&	 
(&& 
$str&& 
)&& 
]&& 
public'' 
async'' 
Task'' 
<'' 
IEnumerable'' %
<''% &
GradeDTO''& .
>''. /
>''/ 0!
GetStudentGradesAsync''1 F
(''F G
Guid''G K
id''L N
)''N O
{''O P
var(( 
grades(( 
=(( 
((( 
await(( 
gradesRepository((  0
.((0 1!
GetGradesStudentAsync((1 F
(((F G
id((G I
)((I J
)((J K
.((K L
Select((L R
(((R S
grades((S Y
=>((Z \
grades((] c
.((c d
AsDto((d i
(((i j
)((j k
)((k l
;((l m
return** 
grades** 
;** 
}++ 	
[.. 	
	Authorize..	 
(.. 
Roles.. 
=.. 
$str.. &
)..& '
]..' (
[// 	
HttpPost//	 
]// 
public00 
async00 
Task00 
<00 
ActionResult00 &
<00& '

StudentDTO00' 1
>001 2
>002 3
AddGrade004 <
(00< =
CreateGradeDTO00= K
createGradeDTO00L Z
)00Z [
{00[ \
	Professor22 
	professor22 
=22  !
await22" ' 
professorsRepository22( <
.22< =
GetProfessorAsync22= N
(22N O
Guid22O S
.22S T
Parse22T Y
(22Y Z
User22Z ^
.22^ _
Claims22_ e
.22e f
FirstOrDefault22f t
(22t u
a22u v
=>22w y
a22z {
.22{ |
Type	22| Ä
==
22Å É
$str
22Ñ à
)
22à â
.
22â ä
Value
22ä è
)
22è ê
)
22ê ë
;
22ë í
Student33 
existingStudent33 #
=33$ %
await33& +
studentsRepository33, >
.33> ?
GetStudentAsync33? N
(33N O
createGradeDTO33O ]
.33] ^
Student33^ e
)33e f
;33f g
if55 
(55 
existingStudent55 
==55 !
null55" &
)55& '
{55' (
return66 
NotFound66 
(66  
new66  #
{66$ %
message77 
=77 
$str77 1
+772 3
createGradeDTO774 B
.77B C
Student77C J
+77K L
$str77M Y
,77Y Z
value88 
=88 
createGradeDTO88 *
.88* +
Value88+ 0
,880 1
date99 
=99 
createGradeDTO99 )
.99) *
Date99* .
}:: 
):: 
;:: 
};; 
List== 
<== 
Guid== 
>== 
existingGrades== %
===& '
new==( +
List==, 0
<==0 1
Guid==1 5
>==5 6
(==6 7
existingStudent==7 F
.==F G
Grades==G M
)==M N
;==N O
Grade?? 
grade?? 
=?? 
new?? 
(?? 
)?? 
{??  
Id@@ 
=@@ 
Guid@@ 
.@@ 
NewGuid@@ !
(@@! "
)@@" #
,@@# $
StudentAA 
=AA 
createGradeDTOAA (
.AA( )
StudentAA) 0
,AA0 1
SubjectBB 
=BB 
	professorBB #
.BB# $
SubjectBB$ +
,BB+ ,
ValueCC 
=CC 
createGradeDTOCC &
.CC& '
ValueCC' ,
,CC, -
DateDD 
=DD 
createGradeDTODD %
.DD% &
DateDD& *
}EE 
;EE 
existingGradesGG 
.GG 
AddGG 
(GG 
gradeGG $
.GG$ %
IdGG% '
)GG' (
;GG( )
awaitJJ 
gradesRepositoryJJ "
.JJ" #
CreateGradeAsyncJJ# 3
(JJ3 4
gradeJJ4 9
)JJ9 :
;JJ: ;
awaitMM 
studentsRepositoryMM $
.MM$ %
UpdateStudentAsyncMM% 7
(MM7 8
newMM8 ;
StudentMM< C
{MMC D
IdNN 
=NN 
existingStudentNN $
.NN$ %
IdNN% '
,NN' (
LastNameOO 
=OO 
existingStudentOO *
.OO* +
LastNameOO+ 3
,OO3 4
	FirstNamePP 
=PP 
existingStudentPP +
.PP+ ,
	FirstNamePP, 5
,PP5 6
CNPQQ 
=QQ 
existingStudentQQ %
.QQ% &
CNPQQ& )
,QQ) *
PasswordRR 
=RR 
existingStudentRR *
.RR* +
PasswordRR+ 3
,RR3 4
GradesSS 
=SS 
existingGradesSS '
.SS' (
ToArraySS( /
(SS/ 0
)SS0 1
,SS1 2
AbsencesTT 
=TT 
existingStudentTT *
.TT* +
AbsencesTT+ 3
,TT3 4
AssignmentsUU 
=UU 
existingStudentUU -
.UU- .
AssignmentsUU. 9
}VV 
)VV 
;VV 
returnXX 
CreatedXX 
(XX 
$strXX $
,XX$ %
gradeXX& +
)XX+ ,
;XX, -
}YY 	
[[[ 	
	Authorize[[	 
([[ 
Roles[[ 
=[[ 
$str[[ &
)[[& '
][[' (
[\\ 	
HttpPut\\	 
(\\ 
$str\\ 
)\\ 
]\\ 
public]] 
async]] 
Task]] 
<]] 
ActionResult]] &
>]]& '#
UpdateStudentGradeAsync]]( ?
(]]? @
Guid]]@ D
id]]E G
,]]G H
UpdateGradeDTO]]I W
updateGradeDTO]]X f
)]]f g
{]]g h
var^^ 
existingItem^^ 
=^^ 
await^^ $
gradesRepository^^% 5
.^^5 6
GetGradeAsync^^6 C
(^^C D
id^^D F
)^^F G
;^^G H
if`` 
(`` 
existingItem`` 
is`` 
null`` #
)``# $
{``$ %
returnaa 
NotFoundaa 
(aa  
)aa  !
;aa! "
}bb 
Gradeff 
updatedGradeff 
=ff  
existingItemff! -
withff. 2
{ff3 4
Idgg 
=gg 
existingItemgg !
.gg! "
Idgg" $
,gg$ %
Studenthh 
=hh 
existingItemhh &
.hh& '
Studenthh' .
,hh. /
Subjectii 
=ii 
existingItemii &
.ii& '
Subjectii' .
,ii. /
Valuejj 
=jj 
updateGradeDTOjj &
.jj& '
Valuejj' ,
,jj, -
Datekk 
=kk 
existingItemkk #
.kk# $
Datekk$ (
}ll 
;ll 
awaitnn 
gradesRepositorynn "
.nn" #
UpdateGradeAsyncnn# 3
(nn3 4
updatedGradenn4 @
)nn@ A
;nnA B
returnpp 
	NoContentpp 
(pp 
)pp 
;pp 
}qq 	
}ss 
}tt ”P
wD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Controllers\StudentsInfoController.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
Controllers! ,
{ 
[ 
ApiController 
] 
[ 
Route 

(
 
$str 
) 
] 
public 

class "
StudentsInfoController '
:( )
ControllerBase* 8
{8 9
private 
readonly 
IStudentsRepository ,

repository- 7
;7 8
private 
readonly 
StudentServices (
studentServices) 8
;8 9
public "
StudentsInfoController %
(% &
IStudentsRepository 

repository  *
,* +
IGradesRepository 
gradesRepository .
,. /
ISubjectsRepository 
subjectsRepository  2
,2 3
IAbsensesRepository 
absensesRepository  2
,2 3"
IAssignmentsRepository "!
assignmentsRepository# 8
)8 9
{9 :
this 
. 

repository 
= 

repository (
;( )
studentServices!! 
=!! 
new!! !
StudentServices!!" 1
(!!1 2
gradesRepository!!2 B
,!!B C
subjectsRepository!!D V
,!!V W
absensesRepository!!X j
,!!j k"
assignmentsRepository	!!l Å
)
!!Å Ç
;
!!Ç É
}"" 	
[$$ 	
	Authorize$$	 
($$ 
Roles$$ 
=$$ 
$str$$ ,
)$$, -
]$$- .
[%% 	
HttpGet%%	 
]%% 
public&& 
async&& 
Task&& 
<&& 
IEnumerable&& %
<&&% &

StudentDTO&&& 0
>&&0 1
>&&1 2
GetStudentsAsync&&3 C
(&&C D
)&&D E
{&&E F
var'' 
students'' 
='' 
('' 
await'' !

repository''" ,
.'', -
GetStudentsAsync''- =
(''= >
)''> ?
)''? @
.(( 
Select(( #
(((# $
student(($ +
=>((, .
student((/ 6
.((6 7
AsDto((7 <
(((< =
)((= >
)((> ?
;((? @
return)) 
students)) 
;)) 
}** 	
[,, 	
	Authorize,,	 
(,, 
Roles,, 
=,, 
$str,, ,
),,, -
],,- .
[-- 	
HttpGet--	 
(-- 
$str-- 
)-- 
]-- 
public.. 
async.. 
Task.. 
<.. 
ActionResult.. &
<..& '
StudentProfileDTO..' 8
>..8 9
>..9 :
GetStudentAsync..; J
(..J K
Guid..K O
id..P R
)..R S
{..S T
var00 
student00 
=00 
await00 

repository00  *
.00* +
GetStudentAsync00+ :
(00: ;
id00; =
)00= >
;00> ?
if22 
(22 
student22 
is22 
null22 
)22  
{22  !
return33 
NotFound33 
(33  
new33  #
{33$ %
message44 
=44 
$str44 5
,445 6
}55 
)55 
;55 
}66 
return88 
await88 
studentServices88 (
.88( )
GetStudentProfile88) :
(88: ;
student88; B
)88B C
;88C D
}99 	
[;; 	
	Authorize;;	 
(;; 
Roles;; 
=;; 
$str;; "
);;" #
];;# $
[<< 	
HttpPost<<	 
]<< 
[== 	
Route==	 
(== 
$str== 
)== 
]== 
public>> 
async>> 
Task>> 
<>> 
IEnumerable>> %
<>>% &"
NewlyCreatedStudentDTO>>& <
>>>< =
>>>= >
CreateStudentsAsync>>? R
(>>R S
List>>S W
<>>W X
CreateStudentDTO>>X h
>>>h i
studentsDTO>>j u
)>>u v
{>>v w
List?? 
<?? "
NewlyCreatedStudentDTO?? '
>??' (#
newlyCreatedStudentDTOs??) @
=??A B
new??C F
List??G K
<??K L"
NewlyCreatedStudentDTO??L b
>??b c
(??c d
)??d e
;??e f
foreach@@ 
(@@ 
CreateStudentDTO@@ $

studentDTO@@% /
in@@0 2
studentsDTO@@3 >
)@@> ?
{@@? @
stringBB 
passwordBB 
=BB  !
RandomHelperBB" .
.BB. / 
GenerateRandomStringBB/ C
(BBC D
$numBBD F
)BBF G
;BBG H
GuidCC 
idCC 
=CC 
GuidCC 
.CC 
NewGuidCC &
(CC& '
)CC' (
;CC( )#
newlyCreatedStudentDTOsEE '
.EE' (
AddEE( +
(EE+ ,
newEE, /
(EE/ 0
)EE0 1
{EE1 2
IdFF 
=FF 
idFF 
,FF 
	FirstNameGG 
=GG 

studentDTOGG  *
.GG* +
	FirstNameGG+ 4
,GG4 5
LastNameHH 
=HH 

studentDTOHH )
.HH) *
LastNameHH* 2
,HH2 3
CNPII 
=II 

studentDTOII $
.II$ %
CNPII% (
,II( )
passwordJJ 
=JJ 
passwordJJ '
}KK 
)KK 
;KK 
StudentMM 
studentMM 
=MM  !
newMM" %
(MM% &
)MM& '
{MM' (
IdNN 
=NN 
idNN 
,NN 
	FirstNameOO 
=OO 

studentDTOOO  *
.OO* +
	FirstNameOO+ 4
,OO4 5
LastNamePP 
=PP 

studentDTOPP )
.PP) *
LastNamePP* 2
,PP2 3
CNPQQ 
=QQ 

studentDTOQQ $
.QQ$ %
CNPQQ% (
,QQ( )
PasswordRR 
=RR 
CryptoHelperRR +
.RR+ ,
hashPasswordRR, 8
(RR8 9
passwordRR9 A
)RRA B
,RRB C
GradesSS 
=SS 
ArraySS "
.SS" #
EmptySS# (
<SS( )
GuidSS) -
>SS- .
(SS. /
)SS/ 0
,SS0 1
AbsencesTT 
=TT 
ArrayTT $
.TT$ %
EmptyTT% *
<TT* +
GuidTT+ /
>TT/ 0
(TT0 1
)TT1 2
,TT2 3
AssignmentsUU 
=UU  !
ArrayUU" '
.UU' (
EmptyUU( -
<UU- .
GuidUU. 2
>UU2 3
(UU3 4
)UU4 5
}VV 
;VV 
awaitXX 

repositoryXX  
.XX  !
CreateStudentAsyncXX! 3
(XX3 4
studentXX4 ;
)XX; <
;XX< =
}YY 
return[[ #
newlyCreatedStudentDTOs[[ *
;[[* +
}\\ 	
[^^ 	
	Authorize^^	 
(^^ 
Roles^^ 
=^^ 
$str^^ ,
)^^, -
]^^- .
[__ 	
HttpPut__	 
(__ 
$str__ 
)__ 
]__ 
public`` 
async`` 
Task`` 
<`` 
ActionResult`` &
>``& '
UpdateStudentAsync``( :
(``: ;
Guid``; ?
id``@ B
,``B C
UpdateStudentDTO``D T

studentDTO``U _
)``_ `
{``` a
varaa 
existingItemaa 
=aa 
awaitaa $

repositoryaa% /
.aa/ 0
GetStudentAsyncaa0 ?
(aa? @
idaa@ B
)aaB C
;aaC D
ifcc 
(cc 
existingItemcc 
iscc 
nullcc #
)cc# $
{cc$ %
returndd 
NotFounddd 
(dd  
)dd  !
;dd! "
}ee 
Studentgg 
updatedStudentgg "
=gg# $
existingItemgg% 1
withgg2 6
{gg7 8
	FirstNamehh 
=hh 

studentDTOhh &
.hh& '
	FirstNamehh' 0
,hh0 1
LastNameii 
=ii 

studentDTOii %
.ii% &
LastNameii& .
,ii. /
CNPjj 
=jj 

studentDTOjj  
.jj  !
CNPjj! $
,jj$ %
}kk 
;kk 
awaitmm 

repositorymm 
.mm 
UpdateStudentAsyncmm /
(mm/ 0
updatedStudentmm0 >
)mm> ?
;mm? @
returnoo 
	NoContentoo 
(oo 
)oo 
;oo 
}pp 	
[rr 	
	Authorizerr	 
(rr 
Rolesrr 
=rr 
$strrr "
)rr" #
]rr# $
[ss 	

HttpDeletess	 
(ss 
$strss 
)ss 
]ss 
publictt 
asynctt 
Tasktt 
<tt 
ActionResulttt &
>tt& '
DeleteStudenttt( 5
(tt5 6
Guidtt6 :
idtt; =
)tt= >
{tt> ?
varuu 
existingItemuu 
=uu 
awaituu $

repositoryuu% /
.uu/ 0
GetStudentAsyncuu0 ?
(uu? @
iduu@ B
)uuB C
;uuC D
ifww 
(ww 
existingItemww 
isww 
nullww #
)ww# $
{ww$ %
returnxx 
NotFoundxx 
(xx  
)xx  !
;xx! "
}yy 

repository{{ 
.{{ 
DeleteStudentAsync{{ )
({{) *
existingItem{{* 6
.{{6 7
Id{{7 9
){{9 :
;{{: ;
return}} 
	NoContent}} 
(}} 
)}} 
;}} 
}~~ 	
}
ÄÄ 
}ÅÅ ë	
oD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\DTO\Absence\AbsenceDataDTO.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
DTO! $
.$ %
Absence% ,
{ 
public 

record 
AbsenceDataDTO  
{  !
public 
Guid 
Id 
{ 
get 
; 
init "
;" #
}$ %
public 
string 
Subject 
{ 
get  #
;# $
init% )
;) *
}+ ,
public 
bool 
excused 
{ 
get !
;! "
init# '
;' (
}) *
public		 
string		 

motivation		  
{		! "
get		# &
;		& '
init		( ,
;		, -
}		. /
public

 
DateTimeOffset

 
Date

 "
{

# $
get

$ '
;

' (
init

) -
;

- .
}

. /
} 
} á	
kD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\DTO\Absence\AbsenceDTO.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
DTO! $
.$ %
Absence% ,
{ 
public 

record 

AbsenceDTO 
{ 
public 
Guid 
Id 
{ 
get 
; 
init "
;" #
}$ %
public 
Guid 
Subject 
{ 
get !
;! "
init# '
;' (
}) *
public 
bool 
excused 
{ 
get !
;! "
init# '
;' (
}) *
public		 
string		 

motivation		  
{		! "
get		# &
;		& '
init		( ,
;		, -
}		. /
public

 
DateTimeOffset

 
Date

 "
{

# $
get

$ '
;

' (
init

) -
;

- .
}

. /
} 
} ≈
qD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\DTO\Absence\CreateAbsenceDTO.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
DTO! $
.$ %
Absence% ,
{ 
public 

record 
CreateAbsenceDTO "
{" #
public 
Guid 
Student 
{ 
get !
;! "
init# '
;' (
}) *
public 
DateTimeOffset 
Date "
{# $
get$ '
;' (
init) -
;- .
}. /
}		 
}

 √
qD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\DTO\Absence\UpdateAbsenceDTO.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
DTO! $
.$ %
Absence% ,
{ 
public 

record 
UpdateAbsenceDTO "
{" #
public 
bool 
excused 
{ 
get !
;! "
init# '
;' (
}) *
public 
string 

motivation  
{! "
get# &
;& '
init( ,
;, -
}. /
} 
}		 ¥
kD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\DTO\Admin\AuthAdminDTO.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
DTO! $
.$ %
Admin% *
{ 
public 

record 
AuthAdminDTO 
{ 
public 
string 
name 
{ 
get  
;  !
init" &
;& '
}( )
public 
string 
Password 
{  
get! $
;$ %
init& *
;* +
}, -
} 
} æ

vD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\DTO\Assignments\AssignmentDataDTO.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
DTO! $
.$ %

Assignment% /
{ 
public 

record 
AssignmentDataDTO #
{# $
public 
Guid 
Id 
{ 
get 
; 
init "
;" #
}$ %
public 
Guid 
Student 
{ 
get !
;! "
init# '
;' (
}) *
public 
string 
Subject 
{ 
get  #
;# $
init% )
;) *
}+ ,
public		 
bool		 
Done		 
{		 
get		 
;		 
init		 #
;		# $
}		$ %
public

 
DateTimeOffset

 
DateFrom

 &
{

' (
get

) ,
;

, -
init

. 2
;

2 3
}

4 5
public 
DateTimeOffset 
DateDue %
{& '
get( +
;+ ,
init- 1
;1 2
}3 4
} 
} ö	
rD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\DTO\Assignments\AssignmentDTO.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
DTO! $
.$ %

Assignment% /
{ 
public 

record 
AssignmentDTO 
{  
public 
Guid 
Id 
{ 
get 
; 
init "
;" #
}$ %
public 
Guid 
Subject 
{ 
get !
;! "
init# '
;' (
}) *
public 
bool 
Done 
{ 
get 
; 
init #
;# $
}$ %
public		 
DateTimeOffset		 
DateFrom		 &
{		' (
get		) ,
;		, -
init		. 2
;		2 3
}		4 5
public

 
DateTimeOffset

 
DateDue

 %
{

& '
get

( +
;

+ ,
init

- 1
;

1 2
}

3 4
} 
} ˙
xD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\DTO\Assignments\CreateAssignmentDTO.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
DTO! $
.$ %

Assignment% /
{ 
public 

record 
CreateAssignmentDTO %
{% &
public 
Guid 
Student 
{ 
get !
;! "
init# '
;' (
}) *
public 
DateTimeOffset 
DateFrom &
{' (
get) ,
;, -
init. 2
;2 3
}4 5
public 
DateTimeOffset 
DateDue %
{& '
get( +
;+ ,
init- 1
;1 2
}3 4
}		 
}

 “
xD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\DTO\Assignments\UpdateAssignmentDTO.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
DTO! $
.$ %

Assignment% /
{ 
public 

record 
UpdateAssignmentDTO %
{% &
public 
bool 
Done 
{ 
get 
; 
init #
;# $
}$ %
public 
DateTimeOffset 
DateDue %
{& '
get( +
;+ ,
init- 1
;1 2
}3 4
} 
}		 ‘
mD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\DTO\Grade\CreateGradeDTO.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
DTO! $
.$ %
Grade% *
{ 
public 

record 
CreateGradeDTO  
{  !
public 
Guid 
Student 
{ 
get !
;! "
init# '
;' (
}) *
public 
int 
Value 
{ 
get 
; 
init  $
;$ %
}& '
public 
DateTimeOffset 
Date "
{# $
get% (
;( )
init* .
;. /
}0 1
}		 
}

 “
kD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\DTO\Grade\GradeDataDTO.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
DTO! $
.$ %
Grade% *
{ 
public 

record 
GradeDataDTO 
{ 
public 
string 
Subject 
{ 
get  #
;# $
init% )
;) *
}+ ,
public 
int 
Value 
{ 
get 
; 
init  $
;$ %
}& '
public 
DateTimeOffset 
Date "
{# $
get% (
;( )
init* .
;. /
}0 1
}		 
}

 ˜
gD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\DTO\Grade\GradeDTO.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
DTO! $
.$ %
Grade% *
{ 
public 

record 
GradeDTO 
{ 
public 
Guid 
Id 
{ 
get 
; 
init "
;" #
}$ %
public 
Guid 
Student 
{ 
get !
;! "
init# '
;' (
}) *
public 
Guid 
Subject 
{ 
get !
;! "
init# '
;' (
}) *
public		 
int		 
Value		 
{		 
get		 
;		 
init		  $
;		$ %
}		& '
public

 
DateTimeOffset

 
Date

 "
{

# $
get

% (
;

( )
init

* .
;

. /
}

0 1
} 
} ô
mD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\DTO\Grade\UpdateGradeDTO.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
DTO! $
.$ %
Grade% *
{ 
public 

record 
UpdateGradeDTO  
{  !
public 
int 
Value 
{ 
get 
; 
init  $
;$ %
}& '
} 
} ƒ
sD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\DTO\Professor\AuthProfessorDTO.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
DTO! $
.$ %
	Professor% .
{ 
public 

record 
AuthProfessorDTO "
{" #
public 
string 
name 
{ 
get  
;  !
init" &
;& '
}( )
public 
string 
Password 
{  
get! $
;$ %
init& *
;* +
}, -
} 
} È
uD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\DTO\Professor\CreateProfessorDTO.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
DTO! $
.$ %
	Professor% .
{ 
public 

record 
CreateProfessorDTO $
{$ %
public 
string 
LastName 
{  
get! $
;$ %
init& *
;* +
}, -
public 
string 
	FirstName 
{  !
get" %
;% &
init' +
;+ ,
}- .
public 
string 
Subject 
{ 
get  #
;# $
init% )
;) *
}+ ,
} 
} ƒ

{D:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\DTO\Professor\NewlyCreatedProfessorDTO.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
DTO! $
.$ %
	Professor% .
{ 
public 

record $
NewlyCreatedProfessorDTO *
{* +
public 
Guid 
Id 
{ 
get 
; 
init !
;! "
}" #
public 
string 
LastName 
{  
get! $
;$ %
init& *
;* +
}, -
public 
string 
	FirstName 
{  !
get" %
;% &
init' +
;+ ,
}- .
public		 
string		 
Subject		 
{		 
get		  #
;		# $
init		% )
;		) *
}		+ ,
public

 
string

 
Password

 
{

  
get

  #
;

# $
init

% )
;

) *
}

* +
public 
string 
username 
{  
get  #
;# $
init% )
;) *
}* +
} 
} ó	
sD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\DTO\Professor\ProfessorDataDTO.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
DTO! $
.$ %
	Professor% .
{ 
public 

record 
ProfessorDataDTO "
{" #
public 
Guid 
Id 
{ 
get 
; 
init "
;" #
}$ %
public 
string 
LastName 
{  
get! $
;$ %
init& *
;* +
}, -
public 
string 
	FirstName 
{  !
get" %
;% &
init' +
;+ ,
}- .
public		 
string		 
Subject		 
{		 
get		  #
;		# $
init		% )
;		) *
}		+ ,
public 
string 
username 
{  
get  #
;# $
init% )
;) *
}* +
} 
} 
oD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\DTO\Professor\ProfessorDTO.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
DTO! $
.$ %
	Professor% .
{ 
public 

record 
ProfessorDTO 
{ 
public 
Guid 
Id 
{ 
get 
; 
init "
;" #
}$ %
public 
string 
LastName 
{  
get! $
;$ %
init& *
;* +
}, -
public 
string 
	FirstName 
{  !
get" %
;% &
init' +
;+ ,
}- .
public		 
Guid		 
Subject		 
{		 
get		 !
;		! "
init		# '
;		' (
}		) *
}

 
} È
uD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\DTO\Professor\UpdateProfessorDTO.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
DTO! $
.$ %
	Professor% .
{ 
public 

record 
UpdateProfessorDTO $
{$ %
public 
string 
LastName 
{  
get! $
;$ %
init& *
;* +
}, -
public 
string 
	FirstName 
{  !
get" %
;% &
init' +
;+ ,
}- .
public 
string 
Subject 
{ 
get  #
;# $
init% )
;) *
}+ ,
}		 
}

 ª
oD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\DTO\Student\AuthStudentDTO.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
DTO! $
.$ %
Student% ,
{ 
public 

record 
AuthStudentDTO  
{  !
public 
string 
CNP 
{ 
get 
;  
init! %
;% &
}' (
public 
string 
Password 
{  
get! $
;$ %
init& *
;* +
}, -
} 
} ˘
qD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\DTO\Student\CreateStudentDTO.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
DTO! $
.$ %
Student% ,
{ 
public 

record 
CreateStudentDTO "
{ 
[		 	
Required			 
]		 
public 
string 
LastName 
{  
get! $
;$ %
init& *
;* +
}, -
[ 	
Required	 
] 
public 
string 
	FirstName 
{  !
get" %
;% &
init' +
;+ ,
}- .
[ 	
Required	 
] 
public 
string 
CNP 
{ 
get 
;  
init! %
;% &
}' (
} 
} õ	
wD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\DTO\Student\NewlyCreatedStudentDTO.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
DTO! $
.$ %
Student% ,
{ 
public 

record "
NewlyCreatedStudentDTO (
{		 
public 
Guid 
Id 
{ 
get 
; 
init !
;! "
}" #
public 
string 
LastName 
{  
get! $
;$ %
init& *
;* +
}, -
public 
string 
	FirstName 
{  !
get" %
;% &
init' +
;+ ,
}- .
public 
string 
CNP 
{ 
get 
;  
init! %
;% &
}' (
public 
string 
password 
{  
get  #
;# $
init% )
;) *
}* +
} 
} Ê
kD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\DTO\Student\StudentDTO.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
DTO! $
.$ %
Student% ,
{ 
public 

record 

StudentDTO 
{ 
public 
Guid 
Id 
{ 
get 
; 
init "
;" #
}$ %
public 
string 
LastName 
{  
get! $
;$ %
init& *
;* +
}, -
public		 
string		 
	FirstName		 
{		  !
get		" %
;		% &
init		' +
;		+ ,
}		- .
public 
string 
CNP 
{ 
get 
; 
init  $
;$ %
}% &
} 
} ›
rD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\DTO\Student\StudentProfileDTO.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
DTO! $
.$ %
Student% ,
{ 
public		 

record		 
StudentProfileDTO		 #
{		# $
public 
Guid 
Id 
{ 
get 
; 
init "
;" #
}$ %
public 
string 
LastName 
{  
get! $
;$ %
init& *
;* +
}, -
public 
string 
	FirstName 
{  !
get" %
;% &
init' +
;+ ,
}- .
public 
List 
< 
GradeDataDTO  
>  !
Grades" (
{) *
get+ .
;. /
init0 4
;4 5
}6 7
public 
List 
< 
AbsenceDataDTO "
>" #
Absences$ ,
{- .
get/ 2
;2 3
init4 8
;8 9
}: ;
public 
List 
< 
AssignmentDataDTO %
>% &
Assignments' 2
{3 4
get5 8
;8 9
init: >
;> ?
}@ A
} 
} ˘
qD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\DTO\Student\UpdateStudentDTO.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
DTO! $
.$ %
Student% ,
{ 
public 

record 
UpdateStudentDTO "
{ 
[		 	
Required			 
]		 
public 
string 
LastName 
{  
get! $
;$ %
init& *
;* +
}, -
[ 	
Required	 
] 
public 
string 
	FirstName 
{  !
get" %
;% &
init' +
;+ ,
}- .
[ 	
Required	 
] 
public 
string 
CNP 
{ 
get 
;  
init! %
;% &
}' (
} 
} ˘	
eD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Entities\Absence.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
Entities! )
{ 
public 

record 
Absence 
{ 
public 
Guid 
Id 
{ 
get 
; 
init "
;" #
}$ %
public 
Guid 
Student 
{ 
get !
;! "
init# '
;' (
}) *
public 
Guid 
Subject 
{ 
get !
;! "
init# '
;' (
}) *
public		 
bool		 
excused		 
{		 
get		 !
;		! "
init		# '
;		' (
}		) *
public

 
string

 

motivation

  
{

! "
get

# &
;

& '
init

( ,
;

, -
}

. /
public 
DateTimeOffset 
Date "
{# $
get% (
;( )
init* .
;. /
}0 1
} 
} Ö

hD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Entities\Assignment.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
Entities! )
{ 
public 

record 

Assignment 
{ 
public 
Guid 
Id 
{ 
get 
; 
init "
;" #
}$ %
public 
Guid 
Student 
{ 
get !
;! "
init# '
;' (
}) *
public 
Guid 
Subject 
{ 
get !
;! "
init# '
;' (
}) *
public		 
bool		 
Done		 
{		 
get		 
;		 
init		 #
;		# $
}		$ %
public

 
DateTimeOffset

 
DateFrom

 &
{

' (
get

) ,
;

, -
init

. 2
;

2 3
}

4 5
public 
DateTimeOffset 
DateDue %
{& '
get( +
;+ ,
init- 1
;1 2
}3 4
} 
} ”
cD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Entities\Grade.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
Entities! )
{ 
public 

record 
Grade 
{ 
public 
Guid 
Id 
{ 
get 
; 
init "
;" #
}$ %
public 
Guid 
Student 
{ 
get !
;! "
init# '
;' (
}) *
public 
Guid 
Subject 
{ 
get !
;! "
init# '
;' (
}) *
public		 
int		 
Value		 
{		 
get		 
;		 
init		  $
;		$ %
}		& '
public

 
DateTimeOffset

 
Date

 "
{

# $
get

% (
;

( )
init

* .
;

. /
}

0 1
} 
} ˛	
gD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Entities\Professor.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
Entities! )
{ 
public 

record 
	Professor 
{ 
public 
Guid 
Id 
{ 
get 
; 
init "
;" #
}$ %
public 
string 
LastName 
{  
get! $
;$ %
init& *
;* +
}, -
public 
string 
	FirstName 
{  !
get" %
;% &
init' +
;+ ,
}- .
public		 
string		 
username		 
{		  
get		  #
;		# $
init		% )
;		) *
}		+ ,
public

 
Guid

 
Subject

 
{

 
get

 !
;

! "
init

# '
;

' (
}

) *
public 
string 
Password 
{  
get  #
;# $
init% )
;) *
}* +
} 
} á
eD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Entities\Student.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
Entities! )
{ 
public 

record 
Student 
{ 
public 
Guid 
Id 
{ 
get 
; 
init "
;" #
}$ %
public 
string 
LastName 
{  
get! $
;$ %
init& *
;* +
}, -
public 
string 
	FirstName 
{  !
get" %
;% &
init' +
;+ ,
}- .
public 
string 
CNP 
{ 
get 
;  
init! %
;% &
}' (
public		 
string		 
Password		 
{		  
get		  #
;		# $
init		% )
;		) *
}		* +
public 
Guid 
[ 
] 
Grades 
{ 
get !
;! "
init# '
;' (
}( )
public 
Guid 
[ 
] 
Absences 
{  
get  #
;# $
init% )
;) *
}* +
public 
Guid 
[ 
] 
Assignments !
{" #
get# &
;& '
init( ,
;, -
}- .
} 
} Ö
eD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Entities\Subject.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
Entities! )
{ 
public 

record 
Subject 
{ 
public 
Guid 
Id 
{ 
get 
; 
init "
;" #
}$ %
public 
string 
Title 
{ 
get !
;! "
init# '
;' (
}) *
} 
}		 ã2
_D:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Extensions.cs
	namespace		 	
TalesOfAForthGrade		
 
.		 
Api		  
{

 
public 

static 
class 

Extensions "
{" #
public 
static 

StudentDTO  
AsDto! &
(& '
this' +
Student, 3
student4 ;
); <
{< =
return 
new 

StudentDTO !
{! "
Id 
= 
student 
. 
Id 
,  
	FirstName 
= 
student #
.# $
	FirstName$ -
,- .
LastName 
= 
student "
." #
LastName# +
,+ ,
CNP 
= 
student 
. 
CNP !
} 
; 
} 	
public 
static 
StudentProfileDTO '
AsProfileDto( 4
(4 5
this5 9
Student: A
studentB I
,I J
ListK O
<O P
GradeDataDTOP \
>\ ]
grades^ d
,d e
Listf j
<j k
AbsenceDataDTOk y
>y z
absences	{ É
,
É Ñ
List
Ö â
<
â ä
AssignmentDataDTO
ä õ
>
õ ú
assignments
ù ®
)
® ©
{
© ™
return 
new 
StudentProfileDTO (
{( )
Id 
= 
student 
. 
Id 
,  
	FirstName 
= 
student #
.# $
	FirstName$ -
,- .
LastName 
= 
student "
." #
LastName# +
,+ ,
Grades 
= 
grades 
,  
Absences 
= 
absences #
,# $
Assignments 
= 
assignments )
} 
; 
} 	
public   
static   
GradeDTO   
AsDto   $
(  $ %
this  % )
Grade  * /
grade  0 5
)  5 6
{  6 7
return!! 
new!! 
GradeDTO!! 
{!!  
Id"" 
="" 
grade"" 
."" 
Id"" 
,"" 
Student## 
=## 
grade## 
.##  
Student##  '
,##' (
Subject$$ 
=$$ 
grade$$ 
.$$  
Subject$$  '
,$$' (
Value%% 
=%% 
grade%% 
.%% 
Value%% #
,%%# $
Date&& 
=&& 
grade&& 
.&& 
Date&& !
}'' 
;'' 
}(( 	
public** 
static** 
ProfessorDTO** "
AsDto**# (
(**( )
this**) -
	Professor**. 7
	professor**8 A
)**A B
{**B C
return++ 
new++ 
ProfessorDTO++ #
{++# $
Id,, 
=,, 
	professor,, 
.,, 
Id,, !
,,,! "
LastName-- 
=-- 
	professor-- $
.--$ %
LastName--% -
,--- .
	FirstName.. 
=.. 
	professor.. %
...% &
	FirstName..& /
,../ 0
Subject// 
=// 
	professor// #
.//# $
Subject//$ +
}00 
;00 
}11 	
public33 
static33 
ProfessorDataDTO33 &
	AsDataDto33' 0
(330 1
this331 5
	Professor336 ?
	professor33@ I
,33I J
string33K Q
subject33R Y
)33Y Z
{33Z [
return44 
new44 
ProfessorDataDTO44 '
{44' (
Id55 
=55 
	professor55 
.55 
Id55 !
,55! "
LastName66 
=66 
	professor66 $
.66$ %
LastName66% -
,66- .
	FirstName77 
=77 
	professor77 %
.77% &
	FirstName77& /
,77/ 0
Subject88 
=88 
subject88 !
,88! "
username99 
=99 
	professor99 $
.99$ %
username99% -
}:: 
;:: 
};; 	
public== 
static== 

AbsenceDTO==  
AsDto==! &
(==& '
this==' +
Entities==, 4
.==4 5
Absence==5 <
absence=== D
)==D E
{==E F
return>> 
new>> 

AbsenceDTO>> !
{>>! "
Id?? 
=?? 
absence?? 
.?? 
Id?? 
,??  
Subject@@ 
=@@ 
absence@@ !
.@@! "
Subject@@" )
,@@) *
excusedAA 
=AA 
absenceAA !
.AA! "
excusedAA" )
,AA) *

motivationBB 
=BB 
absenceBB $
.BB$ %

motivationBB% /
,BB/ 0
DateCC 
=CC 
absenceCC 
.CC 
DateCC #
}DD 
;DD 
}EE 	
publicGG 
staticGG 
AssignmentDTOGG #
AsDtoGG$ )
(GG) *
thisGG* .
EntitiesGG/ 7
.GG7 8

AssignmentGG8 B

assignmentGGC M
)GGM N
{GGN O
returnHH 
newHH 
AssignmentDTOHH $
{HH$ %
IdII 
=II 

assignmentII 
.II  
IdII  "
,II" #
SubjectJJ 
=JJ 

assignmentJJ $
.JJ$ %
SubjectJJ% ,
,JJ, -
DoneKK 
=KK 

assignmentKK !
.KK! "
DoneKK" &
,KK& '
DateFromLL 
=LL 

assignmentLL %
.LL% &
DateFromLL& .
,LL. /
DateDueMM 
=MM 

assignmentMM $
.MM$ %
DateDueMM% ,
}NN 
;NN 
}OO 	
}PP 
}QQ œ 
iD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Helpers\CryptoHelper.cs
	namespace 	
TalesOfAForthGrade
 
. 
Helper #
{# $
public 

static 
class 
CryptoHelper $
{$ %
public 
static 
string 
hashPassword )
() *
string* 0
password1 9
)9 :
{: ;
byte 
[ 
] 
salt 
; 
new $
RNGCryptoServiceProvider ,
(, -
)- .
.. /
GetBytes/ 7
(7 8
salt8 <
== >
new? B
byteC G
[G H
$numH J
]J K
)K L
;L M
var

 
pbkdf2

 
=

 
new

  
Rfc2898DeriveBytes

! 3
(

3 4
password

4 <
,

< =
salt

> B
,

B C
$num

D I
)

I J
;

J K
byte 
[ 
] 
hash 
= 
pbkdf2 $
.$ %
GetBytes% -
(- .
$num. 0
)0 1
;1 2
byte 
[ 
] 
	hashBytes  
=! "
new# &
byte' +
[+ ,
$num, .
]. /
;/ 0
Array 
. 
Copy 
( 
salt 
,  
$num! "
," #
	hashBytes$ -
,- .
$num/ 0
,0 1
$num2 4
)4 5
;5 6
Array 
. 
Copy 
( 
hash 
,  
$num! "
," #
	hashBytes$ -
,- .
$num/ 1
,1 2
$num3 5
)5 6
;6 7
string 
savedPasswordHash (
=) *
Convert+ 2
.2 3
ToBase64String3 A
(A B
	hashBytesB K
)K L
;L M
return 
savedPasswordHash (
;( )
} 	
public 
static 
bool 
comparePasswords +
(+ ,
string, 2
password3 ;
,; <
string= C
hashedPasswordD R
)R S
{S T
byte 
[ 
] 
	hashBytes 
= 
Convert &
.& '
FromBase64String' 7
(7 8
hashedPassword8 F
)F G
;G H
byte 
[ 
] 
salt 
= 
new 
byte "
[" #
$num# %
]% &
;& '
Array 
. 
Copy 
( 
	hashBytes  
,  !
$num" #
,# $
salt% )
,) *
$num+ ,
,, -
$num. 0
)0 1
;1 2
var 
pbkdf2 
= 
new 
Rfc2898DeriveBytes /
(/ 0
password0 8
,8 9
salt: >
,> ?
$num@ E
)E F
;F G
byte 
[ 
] 
hash 
= 
pbkdf2  
.  !
GetBytes! )
() *
$num* ,
), -
;- .
for 
( 
int 
i 
= 
$num 
; 
i 
< 
$num  
;  !
i" #
++# %
)% &
if   
(   
	hashBytes   
[   
i   
+    
$num    "
]  " #
!=  $ &
hash  ' +
[  + ,
i  , -
]  - .
)  . /
return!! 
false!!  
;!!  !
return## 
true## 
;## 
}$$ 	
}%% 
}&& ¡
fD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Helpers\JwtHelper.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
Helper! '
{' (
public

 

class

 
	JwtHelper

 
{ 
public 
static 
JwtSecurityToken &
GetJwtToken' 2
(2 3
string 
id 
, 
string 

signingKey 
, 
string 
issuer 
, 
string 
audience 
, 
int 

expiration 
, 
Claim 
[ 
] 
additionalClaims $
=% &
null' +
)+ ,
{ 	
var 
claims 
= 
new 
[ 
] 
{ 
new 
Claim 
( #
JwtRegisteredClaimNames 1
.1 2
Sub2 5
,5 6
id6 8
)8 9
,9 :
new 
Claim 
( #
JwtRegisteredClaimNames 1
.1 2
Jti2 5
,5 6
Guid7 ;
.; <
NewGuid< C
(C D
)D E
.E F
ToStringF N
(N O
)O P
)P Q
} 
; 
if 
( 
additionalClaims  
is! #
object$ *
)* +
{ 
var 
	claimList 
= 
new  #
List$ (
<( )
Claim) .
>. /
(/ 0
claims0 6
)6 7
;7 8
	claimList 
. 
AddRange "
(" #
additionalClaims# 3
)3 4
;4 5
claims 
= 
	claimList "
." #
ToArray# *
(* +
)+ ,
;, -
}   
var"" 
key"" 
="" 
new""  
SymmetricSecurityKey"" .
("". /
Encoding""/ 7
.""7 8
UTF8""8 <
.""< =
GetBytes""= E
(""E F

signingKey""F P
)""P Q
)""Q R
;""R S
var## 
creds## 
=## 
new## 
SigningCredentials## .
(##. /
key##/ 2
,##2 3
SecurityAlgorithms##4 F
.##F G

HmacSha256##G Q
)##Q R
;##R S
return%% 
new%% 
JwtSecurityToken%% '
(%%' (
issuer&& 
:&& 
issuer&& 
,&& 
audience'' 
:'' 
audience'' "
,''" #
expires(( 
:(( 
DateTime(( !
.((! "
UtcNow((" (
.((( )
AddHours(() 1
(((1 2

expiration((2 <
)((< =
,((= >
claims)) 
:)) 
claims)) 
,)) 
signingCredentials** "
:**" #
creds**$ )
)++ 
;++ 
},, 	
}-- 
}.. Ã
iD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Helpers\RandomHelper.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
Helper! '
{' (
public 

static 
class 
RandomHelper $
{ 
const		 
string		 
chars		 
=		 
$str		 ]
;		] ^
private

 
static

 !
RandomNumberGenerator

 ,
random

- 3
=

4 5
new

6 9$
RNGCryptoServiceProvider

: R
(

R S
)

S T
;

T U
public 
static 
string  
GenerateRandomString 1
(1 2
int2 5
length6 <
)< =
{= >
return 
new 
string 
( 

Enumerable )
.) *
Repeat* 0
(0 1
chars1 6
,6 7
length8 >
)> ?
. 
Select 
( 
s 
=> 
s 
[ 
RandomIntFromRNG /
(/ 0
s0 1
.1 2
Length2 8
)8 9
]9 :
): ;
.; <
ToArray< C
(C D
)D E
)E F
;F G
} 	
private 
static 
int 
RandomIntFromRNG +
(+ ,
int, /
max0 3
)3 4
{ 	
byte 
[ 
] 

four_bytes 
= 
new  #
byte$ (
[( )
$num) *
]* +
;+ ,
random 
. 
GetBytes 
( 

four_bytes &
)& '
;' (
UInt32 
scale 
= 
BitConverter '
.' (
ToUInt32( 0
(0 1

four_bytes1 ;
,; <
$num= >
)> ?
;? @
return 
( 
int 
) 
( 
( 
max 
) 
*  
(! "
scale" '
/( )
(* +
uint+ /
./ 0
MaxValue0 8
+9 :
$num; >
)> ?
)? @
)@ A
;A B
} 	
} 
} ‹

\D:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Program.cs
	namespace

 	
TalesOfAForthGrade


 
.

 
Api

  
{ 
public 

class 
Program 
{ 
public 
static 
void 
Main 
(  
string  &
[& '
]' (
args) -
)- .
{ 	
CreateHostBuilder 
( 
args "
)" #
.# $
Build$ )
() *
)* +
.+ ,
Run, /
(/ 0
)0 1
;1 2
} 	
public 
static 
IHostBuilder "
CreateHostBuilder# 4
(4 5
string5 ;
[; <
]< =
args> B
)B C
=>D F
Host 
.  
CreateDefaultBuilder %
(% &
args& *
)* +
. $
ConfigureWebHostDefaults )
() *

webBuilder* 4
=>5 7
{ 

webBuilder 
. 

UseStartup )
<) *
Startup* 1
>1 2
(2 3
)3 4
;4 5
} 
) 
; 
} 
} µ
uD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Repositories\IAbsensesRepository.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
Repositories! -
{ 
public 

	interface 
IAbsensesRepository (
{		 
Task 
< 
Absence 
> 

GetAbsence  
(  !
Guid! %
	absenceId& /
)/ 0
;0 1
Task 
< 
IEnumerable 
< 
Absence  
>  !
>! "#
GetAbsencesStudentAsync# :
(: ;
Guid; ?
	studentId@ I
)I J
;J K
Task 
CreateAbsenceAsync 
(  
Absence  '
absence( /
)/ 0
;0 1
Task 
UpdateAbsenceAsync 
(  
Absence  '
absence( /
)/ 0
;0 1
} 
} ‚
xD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Repositories\IAssignmentsRepository.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
Repositories! -
{ 
public 

	interface "
IAssignmentsRepository +
{		 
Task 
< 

Assignment 
> 
GetAssignmentAsync +
(+ ,
Guid, 0
assignmentId1 =
)= >
;> ?
Task 
< 
IEnumerable 
< 

Assignment #
># $
>$ %&
GetAssignmentsStudentAsync& @
(@ A
GuidA E
	studentIdF O
)O P
;P Q
Task !
CreateAssignmentAsync "
(" #

Assignment# -

assignment. 8
)8 9
;9 :
Task "
UpdateAssignmentsAsync #
(# $

Assignment$ .

assignment/ 9
)9 :
;: ;
} 
} ﬁ	
sD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Repositories\IGradesRepository.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
Repositories! -
{ 
public 

	interface 
IGradesRepository &
{		 
Task

 
<

 
Grade

 
>

 
GetGradeAsync

 !
(

! "
Guid

" &
id

' )
)

) *
;

* +
Task 
< 
IEnumerable 
< 
Grade 
> 
>  !
GetGradesStudentAsync! 6
(6 7
Guid7 ;
	studentId< E
)E F
;F G
Task 
< 
IEnumerable 
< 
Grade 
> 
>  
GetGradesAsync! /
(/ 0
)0 1
;1 2
Task 
CreateGradeAsync 
( 
Grade #
grade$ )
)) *
;* +
Task 
UpdateGradeAsync 
( 
Grade #
grade$ )
)) *
;* +
} 
} ’

vD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Repositories\IProfessorRepository.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
Repositories! -
{ 
public 

	interface  
IProfessorRepository )
{		 
Task

 
<

 
IEnumerable

 
<

 
	Professor

 "
>

" #
>

# $
GetProfessorsAsync

% 7
(

7 8
)

8 9
;

9 :
Task 
< 
	Professor 
> 
GetProfessorAsync )
() *
Guid* .
id/ 1
)1 2
;2 3
Task 
< 
	Professor 
> 
GetProfessorAsync )
() *
string* 0
name1 5
)5 6
;6 7
Task  
CreateProfessorAsync !
(! "
	Professor" +
	professor, 5
)5 6
;6 7
Task  
UpdateProfessorAsync !
(! "
	Professor" +
	professor, 5
)5 6
;6 7
void  
DeleteProfessorAsync !
(! "
Guid" &
id' )
)) *
;* +
} 
} ∏

uD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Repositories\IStudentsRepository.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
Repositories! -
{ 
public 

	interface 
IStudentsRepository (
{		 
Task

 
<

 
Student

 
>

 
GetStudentAsync

 %
(

% &
Guid

& *
id

+ -
)

- .
;

. /
Task 
< 
Student 
> 
GetStudentAsync %
(% &
String& ,
cnp- 0
)0 1
;1 2
Task 
< 
IEnumerable 
< 
Student  
>  !
>! "
GetStudentsAsync# 3
(3 4
)4 5
;5 6
Task 
CreateStudentAsync 
(  
Student  '
student( /
)/ 0
;0 1
Task 
UpdateStudentAsync 
(  
Student  '
student( /
)/ 0
;0 1
void 
DeleteStudentAsync 
(  
Guid  $
id% '
)' (
;( )
} 
} Ø
uD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Repositories\ISubjectsRepository.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
Repositories! -
{ 
public 

	interface 
ISubjectsRepository (
{		 
Task

 
<

 
Subject

 
>

 
GetSubjectAsync

 %
(

% &
Guid

& *
id

+ -
)

- .
;

. /
Task 
< 
Subject 
> 
GetSubjectAsync %
(% &
string& ,
name- 1
)1 2
;2 3
Task 
< 
IEnumerable 
< 
Subject  
>  !
>! "
GetSubjectsAsync# 3
(3 4
)4 5
;5 6
Task 
CreateSubjectAsync 
(  
Subject  '
subject( /
)/ 0
;0 1
} 
} ≈"
{D:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Repositories\MongoDbAbsensesRepository.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
Repositories! -
{		 
public

 

class

 %
MongoDbAbsensesRepository

 *
:

+ ,
IAbsensesRepository

- @
{ 
private 
const 
string 
databaseName )
=* +
$str, 3
;3 4
private 
const 
string 
collectionName +
=, -
$str. 7
;7 8
private 
readonly 
IMongoCollection )
<) *
Absence* 1
>1 2
absensesCollection3 E
;E F
private 
readonly #
FilterDefinitionBuilder 0
<0 1
Absence1 8
>8 9
filterBuilder: G
=H I
BuildersJ R
<R S
AbsenceS Z
>Z [
.[ \
Filter\ b
;b c
public %
MongoDbAbsensesRepository (
(( )
IMongoClient) 5
mongoClient6 A
)A B
{B C
IMongoDatabase 
database #
=$ %
mongoClient& 1
.1 2
GetDatabase2 =
(= >
databaseName> J
)J K
;K L
absensesCollection 
=  
database! )
.) *
GetCollection* 7
<7 8
Absence8 ?
>? @
(@ A
collectionNameA O
)O P
;P Q
} 	
public 
async 
Task 
CreateAbsenceAsync ,
(, -
Absence- 4
absence5 <
)< =
{ 	
await 
absensesCollection $
.$ %
InsertOneAsync% 3
(3 4
absence4 ;
); <
;< =
} 	
public 
async 
Task 
< 
Absence !
>! "

GetAbsence# -
(- .
Guid. 2
	absenceId3 <
)< =
{ 	
var 
filter 
= 
filterBuilder &
.& '
Eq' )
() *
absence* 1
=>2 4
absence5 <
.< =
Id= ?
,? @
	absenceIdA J
)J K
;K L
return 
await 
absensesCollection +
.+ ,
Find, 0
(0 1
filter1 7
)7 8
.8 9 
SingleOrDefaultAsync9 M
(M N
)N O
;O P
}   	
public"" 
async"" 
Task"" 
<"" 
IEnumerable"" %
<""% &
Absence""& -
>""- .
>"". /#
GetAbsencesStudentAsync""0 G
(""G H
Guid""H L
	studentId""M V
)""V W
{## 	
var$$ 
filter$$ 
=$$ 
filterBuilder$$ &
.$$& '
Eq$$' )
($$) *
absence$$* 1
=>$$2 4
absence$$5 <
.$$< =
Student$$= D
,$$D E
	studentId$$F O
)$$O P
;$$P Q
return%% 
await%% 
absensesCollection%% +
.%%+ ,
Find%%, 0
(%%0 1
filter%%1 7
)%%7 8
.%%8 9
ToListAsync%%9 D
(%%D E
)%%E F
;%%F G
}&& 	
public(( 
async(( 
Task(( 
UpdateAbsenceAsync(( ,
(((, -
Absence((- 4
absence((5 <
)((< =
{)) 	
var** 
filter** 
=** 
filterBuilder** &
.**& '
Eq**' )
(**) *

oldAbsense*** 4
=>**5 7

oldAbsense**8 B
.**B C
Id**C E
,**E F
absence**G N
.**N O
Id**O Q
)**Q R
;**R S
await++ 
absensesCollection++ $
.++$ %
ReplaceOneAsync++% 4
(++4 5
filter++5 ;
,++; <
absence++= D
)++D E
;++E F
},, 	
}-- 
}.. ¨#
~D:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Repositories\MongoDbAssignmentRepossitory.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
Repositories! -
{		 
public

 

class

 '
MongoDbAssignmentRepository

 ,
:

- ."
IAssignmentsRepository

/ E
{ 
private 
const 
string 
databaseName )
=* +
$str, 3
;3 4
private 
const 
string 
collectionName +
=, -
$str. ;
;; <
private 
readonly 
IMongoCollection )
<) *

Assignment* 4
>4 5!
assignmentsCollection6 K
;K L
private 
readonly #
FilterDefinitionBuilder 0
<0 1

Assignment1 ;
>; <
filterBuilder= J
=K L
BuildersM U
<U V

AssignmentV `
>` a
.a b
Filterb h
;h i
public '
MongoDbAssignmentRepository *
(* +
IMongoClient+ 7
mongoClient8 C
)C D
{D E
IMongoDatabase 
database #
=$ %
mongoClient& 1
.1 2
GetDatabase2 =
(= >
databaseName> J
)J K
;K L!
assignmentsCollection !
=" #
database$ ,
., -
GetCollection- :
<: ;

Assignment; E
>E F
(F G
collectionNameG U
)U V
;V W
} 	
public 
async 
Task !
CreateAssignmentAsync /
(/ 0

Assignment0 :

assignment; E
)E F
{ 	
await !
assignmentsCollection '
.' (
InsertOneAsync( 6
(6 7

assignment7 A
)A B
;B C
} 	
public 
async 
Task 
< 

Assignment $
>$ %
GetAssignmentAsync& 8
(8 9
Guid9 =
assignmentId> J
)J K
{ 	
var 
filter 
= 
filterBuilder &
.& '
Eq' )
() *
absence* 1
=>2 4
absence5 <
.< =
Id= ?
,? @
assignmentIdA M
)M N
;N O
return 
await !
assignmentsCollection .
.. /
Find/ 3
(3 4
filter4 :
): ;
.; < 
SingleOrDefaultAsync< P
(P Q
)Q R
;R S
}   	
public"" 
async"" 
Task"" 
<"" 
IEnumerable"" %
<""% &

Assignment""& 0
>""0 1
>""1 2&
GetAssignmentsStudentAsync""3 M
(""M N
Guid""N R
	studentId""S \
)""\ ]
{## 	
var$$ 
filter$$ 
=$$ 
filterBuilder$$ &
.$$& '
Eq$$' )
($$) *

assignment$$* 4
=>$$5 7

assignment$$8 B
.$$B C
Student$$C J
,$$J K
	studentId$$L U
)$$U V
;$$V W
return%% 
await%% !
assignmentsCollection%% .
.%%. /
Find%%/ 3
(%%3 4
filter%%4 :
)%%: ;
.%%; <
ToListAsync%%< G
(%%G H
)%%H I
;%%I J
}&& 	
public(( 
async(( 
Task(( "
UpdateAssignmentsAsync(( 0
(((0 1

Assignment((1 ;

assignment((< F
)((F G
{)) 	
var** 
filter** 
=** 
filterBuilder** &
.**& '
Eq**' )
(**) *
oldAssignment*** 7
=>**8 :
oldAssignment**; H
.**H I
Id**I K
,**K L

assignment**M W
.**W X
Id**X Z
)**Z [
;**[ \
await++ !
assignmentsCollection++ '
.++' (
ReplaceOneAsync++( 7
(++7 8
filter++8 >
,++> ?

assignment++@ J
)++J K
;++K L
},, 	
}.. 
}// ï&
yD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Repositories\MongoDbGradesRepository.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
Repositories! -
{		 
public

 

class

 #
MongoDbGradesRepository

 (
:

) *
IGradesRepository

+ <
{ 
private 
const 
string 
databaseName )
=* +
$str, 3
;3 4
private 
const 
string 
collectionName +
=, -
$str. 6
;6 7
private 
readonly 
IMongoCollection )
<) *
Grade* /
>/ 0
gradesCollection1 A
;A B
private 
readonly #
FilterDefinitionBuilder 0
<0 1
Grade1 6
>6 7
filterBuilder8 E
=F G
BuildersH P
<P Q
GradeQ V
>V W
.W X
FilterX ^
;^ _
public #
MongoDbGradesRepository &
(& '
IMongoClient' 3
mongoClient4 ?
)? @
{@ A
IMongoDatabase 
database #
=$ %
mongoClient& 1
.1 2
GetDatabase2 =
(= >
databaseName> J
)J K
;K L
gradesCollection 
= 
database '
.' (
GetCollection( 5
<5 6
Grade6 ;
>; <
(< =
collectionName= K
)K L
;L M
} 	
public 
async 
Task 
CreateGradeAsync *
(* +
Grade+ 0
grade1 6
)6 7
{ 	
await 
gradesCollection "
." #
InsertOneAsync# 1
(1 2
grade2 7
)7 8
;8 9
} 	
public 
async 
Task 
< 
Grade 
>  
GetGradeAsync! .
(. /
Guid/ 3
id4 6
)6 7
{ 	
var 
filter 
= 
filterBuilder &
.& '
Eq' )
() *
grade* /
=>0 2
grade3 8
.8 9
Id9 ;
,; <
id= ?
)? @
;@ A
return 
await 
gradesCollection )
.) *
Find* .
(. /
filter/ 5
)5 6
.6 7 
SingleOrDefaultAsync7 K
(K L
)L M
;M N
}   	
public"" 
async"" 
Task"" 
<"" 
IEnumerable"" %
<""% &
Grade""& +
>""+ ,
>"", -
GetGradesAsync"". <
(""< =
)""= >
{## 	
return$$ 
await$$ 
gradesCollection$$ )
.$$) *
Find$$* .
($$. /
new$$/ 2
BsonDocument$$3 ?
($$? @
)$$@ A
)$$A B
.$$B C
ToListAsync$$C N
($$N O
)$$O P
;$$P Q
}%% 	
public'' 
async'' 
Task'' 
<'' 
IEnumerable'' %
<''% &
Grade''& +
>''+ ,
>'', -!
GetGradesStudentAsync''. C
(''C D
Guid''D H
	studentId''I R
)''R S
{(( 	
var)) 
filter)) 
=)) 
filterBuilder)) &
.))& '
Eq))' )
())) *
grade))* /
=>))0 2
grade))3 8
.))8 9
Student))9 @
,))@ A
	studentId))B K
)))K L
;))L M
return** 
await** 
gradesCollection** )
.**) *
Find*** .
(**. /
filter**/ 5
)**5 6
.**6 7
ToListAsync**7 B
(**B C
)**C D
;**D E
}++ 	
public-- 
async-- 
Task-- 
UpdateGradeAsync-- *
(--* +
Grade--+ 0
grade--1 6
)--6 7
{.. 	
var// 
filter// 
=// 
filterBuilder// &
.//& '
Eq//' )
(//) *
oldGrade//* 2
=>//3 5
oldGrade//6 >
.//> ?
Id//? A
,//A B
grade//C H
.//H I
Id//I K
)//K L
;//L M
await00 
gradesCollection00 "
.00" #
ReplaceOneAsync00# 2
(002 3
filter003 9
,009 :
grade00; @
)00@ A
;00A B
}11 	
}22 
}33 À+
|D:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Repositories\MongoDbProfessorRepository.cs
	namespace		 	
TalesOfAForthGrade		
 
.		 
Api		  
.		  !
Repositories		! -
{

 
public 

class &
MongoDbProfessorRepository +
:, - 
IProfessorRepository. B
{ 
private 
const 
string 
databaseName )
=* +
$str, 3
;3 4
private 
const 
string 
collectionName +
=, -
$str. :
;: ;
private 
readonly 
IMongoCollection )
<) *
	Professor* 3
>3 4 
professorsCollection5 I
;I J
private 
readonly #
FilterDefinitionBuilder 0
<0 1
	Professor1 :
>: ;
filterBuilder< I
=J K
BuildersL T
<T U
	ProfessorU ^
>^ _
._ `
Filter` f
;f g
public &
MongoDbProfessorRepository )
() *
IMongoClient* 6
mongoClient7 B
)B C
{C D
IMongoDatabase 
database #
=$ %
mongoClient& 1
.1 2
GetDatabase2 =
(= >
databaseName> J
)J K
;K L 
professorsCollection  
=! "
database# +
.+ ,
GetCollection, 9
<9 :
	Professor: C
>C D
(D E
collectionNameE S
)S T
;T U
} 	
public 
async 
Task  
CreateProfessorAsync .
(. /
	Professor/ 8
	professor9 B
)B C
{ 	
await  
professorsCollection &
.& '
InsertOneAsync' 5
(5 6
	professor6 ?
)? @
;@ A
} 	
public 
async 
void  
DeleteProfessorAsync .
(. /
Guid/ 3
id4 6
)6 7
{ 	
var 
filter 
= 
filterBuilder &
.& '
Eq' )
() *
prof* .
=>/ 1
prof2 6
.6 7
Id7 9
,9 :
id; =
)= >
;> ?
await    
professorsCollection   &
.  & '
DeleteOneAsync  ' 5
(  5 6
filter  6 <
)  < =
;  = >
}!! 	
public## 
async## 
Task## 
<## 
	Professor## #
>### $
GetProfessorAsync##% 6
(##6 7
string##7 =
name##> B
)##B C
{##C D
var$$ 
filter$$ 
=$$ 
filterBuilder$$ &
.$$& '
Eq$$' )
($$) *
prof$$* .
=>$$/ 1
prof$$2 6
.$$6 7
username$$7 ?
,$$? @
name$$A E
)$$E F
;$$F G
return%% 
await%%  
professorsCollection%% -
.%%- .
Find%%. 2
(%%2 3
filter%%3 9
)%%9 :
.%%: ; 
SingleOrDefaultAsync%%; O
(%%O P
)%%P Q
;%%Q R
}&& 	
public(( 
async(( 
Task(( 
<(( 
	Professor(( #
>((# $
GetProfessorAsync((% 6
(((6 7
Guid((7 ;
id((< >
)((> ?
{)) 	
var** 
filter** 
=** 
filterBuilder** &
.**& '
Eq**' )
(**) *
	professor*** 3
=>**4 6
	professor**7 @
.**@ A
Id**A C
,**C D
id**E G
)**G H
;**H I
return++ 
await++  
professorsCollection++ -
.++- .
Find++. 2
(++2 3
filter++3 9
)++9 :
.++: ; 
SingleOrDefaultAsync++; O
(++O P
)++P Q
;++Q R
},, 	
public.. 
async.. 
Task.. 
<.. 
IEnumerable.. %
<..% &
	Professor..& /
>../ 0
>..0 1
GetProfessorsAsync..2 D
(..D E
)..E F
{// 	
return00 
await00  
professorsCollection00 -
.00- .
Find00. 2
(002 3
new003 6
BsonDocument007 C
(00C D
)00D E
)00E F
.00F G
ToListAsync00G R
(00R S
)00S T
;00T U
}11 	
public33 
async33 
Task33  
UpdateProfessorAsync33 .
(33. /
	Professor33/ 8
	professor339 B
)33B C
{44 	
var55 
filter55 
=55 
filterBuilder55 &
.55& '
Eq55' )
(55) *
existingProfessor55* ;
=>55< >
existingProfessor55? P
.55P Q
Id55Q S
,55S T
	professor55U ^
.55^ _
Id55_ a
)55a b
;55b c
await66  
professorsCollection66 &
.66& '
ReplaceOneAsync66' 6
(666 7
filter667 =
,66= >
	professor66? H
)66H I
;66I J
}77 	
}88 
}99 â+
zD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Repositories\MongoDbStudentRepository.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
Repositories! -
{		 
public

 

class

 $
MongoDbStudentRepository

 )
:

* +
IStudentsRepository

, ?
{ 
private 
const 
string 
databaseName )
=* +
$str, 3
;3 4
private 
const 
string 
collectionName +
=, -
$str. 8
;8 9
private 
readonly 
IMongoCollection )
<) *
Student* 1
>1 2
studentsCollection3 E
;E F
private 
readonly #
FilterDefinitionBuilder 0
<0 1
Student1 8
>8 9
filterBuilder: G
=H I
BuildersJ R
<R S
StudentS Z
>Z [
.[ \
Filter\ b
;b c
public $
MongoDbStudentRepository '
(' (
IMongoClient( 4
mongoClient5 @
)@ A
{A B
IMongoDatabase 
database #
=$ %
mongoClient& 1
.1 2
GetDatabase2 =
(= >
databaseName> J
)J K
;K L
studentsCollection 
=  
database! )
.) *
GetCollection* 7
<7 8
Student8 ?
>? @
(@ A
collectionNameA O
)O P
;P Q
} 	
public 
async 
Task 
CreateStudentAsync ,
(, -
Student- 4
student5 <
)< =
{ 	
await 
studentsCollection $
.$ %
InsertOneAsync% 3
(3 4
student4 ;
); <
;< =
} 	
public 
async 
void 
DeleteStudentAsync ,
(, -
Guid- 1
id2 4
)4 5
{ 	
var 
filter 
= 
filterBuilder &
.& '
Eq' )
() *
student* 1
=>2 4
student5 <
.< =
Id= ?
,? @
idA C
)C D
;D E
await 
studentsCollection $
.$ %
DeleteOneAsync% 3
(3 4
filter4 :
): ;
;; <
}   	
public"" 
async"" 
Task"" 
<"" 
Student"" !
>""! "
GetStudentAsync""# 2
(""2 3
String""3 9
cnp"": =
)""= >
{""> ?
var## 
filter## 
=## 
filterBuilder## &
.##& '
Eq##' )
(##) *
student##* 1
=>##2 4
student##5 <
.##< =
CNP##= @
,##@ A
cnp##B E
)##E F
;##F G
return$$ 
await$$ 
studentsCollection$$ +
.$$+ ,
Find$$, 0
($$0 1
filter$$1 7
)$$7 8
.$$8 9 
SingleOrDefaultAsync$$9 M
($$M N
)$$N O
;$$O P
}%% 	
public'' 
async'' 
Task'' 
<'' 
Student'' !
>''! "
GetStudentAsync''# 2
(''2 3
Guid''3 7
id''8 :
)'': ;
{(( 	
var)) 
filter)) 
=)) 
filterBuilder)) &
.))& '
Eq))' )
())) *
student))* 1
=>))2 4
student))5 <
.))< =
Id))= ?
,))? @
id))A C
)))C D
;))D E
return** 
await** 
studentsCollection** +
.**+ ,
Find**, 0
(**0 1
filter**1 7
)**7 8
.**8 9 
SingleOrDefaultAsync**9 M
(**M N
)**N O
;**O P
}++ 	
public-- 
async-- 
Task-- 
<-- 
IEnumerable-- %
<--% &
Student--& -
>--- .
>--. /
GetStudentsAsync--0 @
(--@ A
)--A B
{.. 	
return// 
await// 
studentsCollection// +
.//+ ,
Find//, 0
(//0 1
new//1 4
BsonDocument//5 A
(//A B
)//B C
)//C D
.//D E
ToListAsync//E P
(//P Q
)//Q R
;//R S
}00 	
public22 
async22 
Task22 
UpdateStudentAsync22 ,
(22, -
Student22- 4
student225 <
)22< =
{33 	
var44 
filter44 
=44 
filterBuilder44 &
.44& '
Eq44' )
(44) *
existingStudent44* 9
=>44: <
existingStudent44= L
.44L M
Id44M O
,44O P
student44Q X
.44X Y
Id44Y [
)44[ \
;44\ ]
await55 
studentsCollection55 $
.55$ %
ReplaceOneAsync55% 4
(554 5
filter555 ;
,55; <
student55= D
)55D E
;55E F
}66 	
}77 
}88 ⁄ 
zD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Repositories\MongoDbSubjectRepository.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
Repositories! -
{		 
public

 

class

 $
MongoDbSubjectRepository

 )
:

* +
ISubjectsRepository

, ?
{ 
private 
const 
string 
databaseName )
=* +
$str, 3
;3 4
private 
const 
string 
collectionName +
=, -
$str. 8
;8 9
private 
readonly 
IMongoCollection )
<) *
Subject* 1
>1 2
subjectsCollection3 E
;E F
private 
readonly #
FilterDefinitionBuilder 0
<0 1
Subject1 8
>8 9
filterBuilder: G
=H I
BuildersJ R
<R S
SubjectS Z
>Z [
.[ \
Filter\ b
;b c
public $
MongoDbSubjectRepository '
(' (
IMongoClient( 4
mongoClient5 @
)@ A
{A B
IMongoDatabase 
database #
=$ %
mongoClient& 1
.1 2
GetDatabase2 =
(= >
databaseName> J
)J K
;K L
subjectsCollection 
=  
database! )
.) *
GetCollection* 7
<7 8
Subject8 ?
>? @
(@ A
collectionNameA O
)O P
;P Q
} 	
public 
async 
Task 
CreateSubjectAsync ,
(, -
Subject- 4
subject5 <
)< =
{ 	
await 
subjectsCollection $
.$ %
InsertOneAsync% 3
(3 4
subject4 ;
); <
;< =
} 	
public 
async 
Task 
< 
Subject !
>! "
GetSubjectAsync# 2
(2 3
Guid3 7
id8 :
): ;
{ 	
var 
filter 
= 
filterBuilder &
.& '
Eq' )
() *
subject* 1
=>2 4
subject5 <
.< =
Id= ?
,? @
idA C
)C D
;D E
return 
await 
subjectsCollection +
.+ ,
Find, 0
(0 1
filter1 7
)7 8
.8 9 
SingleOrDefaultAsync9 M
(M N
)N O
;O P
}   	
public"" 
async"" 
Task"" 
<"" 
Subject"" !
>""! "
GetSubjectAsync""# 2
(""2 3
string""3 9
name"": >
)""> ?
{## 	
var$$ 
filter$$ 
=$$ 
filterBuilder$$ &
.$$& '
Eq$$' )
($$) *
subject$$* 1
=>$$2 4
subject$$5 <
.$$< =
Title$$= B
,$$B C
name$$D H
)$$H I
;$$I J
return%% 
await%% 
subjectsCollection%% +
.%%+ ,
Find%%, 0
(%%0 1
filter%%1 7
)%%7 8
.%%8 9 
SingleOrDefaultAsync%%9 M
(%%M N
)%%N O
;%%O P
}&& 	
public(( 
async(( 
Task(( 
<(( 
IEnumerable(( %
<((% &
Subject((& -
>((- .
>((. /
GetSubjectsAsync((0 @
(((@ A
)((A B
{)) 	
return** 
await** 
subjectsCollection** +
.**+ ,
Find**, 0
(**0 1
new**1 4
BsonDocument**5 A
(**A B
)**B C
)**C D
.**D E
ToListAsync**E P
(**P Q
)**Q R
;**R S
}++ 	
},, 
}-- Ê5
mD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Services\StudentServices.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
Services! )
{) *
public 

class 
StudentServices  
{  !
private 
readonly 
IGradesRepository *
gradesRepository+ ;
;; <
private 
readonly 
ISubjectsRepository ,
subjectsRepository- ?
;? @
private 
readonly 
IAbsensesRepository ,
absensesRepository- ?
;? @
private 
readonly "
IAssignmentsRepository /!
assignmentsRepository0 E
;E F
public 
StudentServices 
( 
IGradesRepository 
gradesRepository *
,* +
ISubjectsRepository 
subjectsRepository .
,. /
IAbsensesRepository 
absensesRepository .
,. /"
IAssignmentsRepository !
assignmentsRepository 4
)4 5
{5 6
this 
. 
gradesRepository !
=" #
gradesRepository$ 4
;4 5
this 
. 
subjectsRepository #
=$ %
subjectsRepository& 8
;8 9
this 
. 
absensesRepository #
=$ %
absensesRepository& 8
;8 9
this 
. !
assignmentsRepository &
=' (!
assignmentsRepository) >
;> ?
} 	
public   
async   
Task   
<   
ActionResult   &
<  & '
StudentProfileDTO  ' 8
>  8 9
>  9 :
GetStudentProfile  ; L
(  L M
Student  M T
student  U \
)  \ ]
{  ] ^
var"" 
grades"" 
="" 
await"" 
gradesRepository"" /
.""/ 0!
GetGradesStudentAsync""0 E
(""E F
student""F M
.""M N
Id""N P
)""P Q
;""Q R
List$$ 
<$$ 
GradeDataDTO$$ 
>$$ 
	gradesDto$$ (
=$$) *
new$$+ .
List$$/ 3
<$$3 4
GradeDataDTO$$4 @
>$$@ A
($$A B
)$$B C
;$$C D
foreach&& 
(&& 
Grade&& 
grade&& 
in&&  "
grades&&# )
)&&) *
{&&* +
	gradesDto'' 
.'' 
Add'' 
('' 
new'' !
GradeDataDTO''" .
{''. /
Subject(( 
=(( 
((( 
await(( $
subjectsRepository((% 7
.((7 8
GetSubjectAsync((8 G
(((G H
grade((H M
.((M N
Subject((N U
)((U V
)((V W
.((W X
Title((X ]
,((] ^
Value)) 
=)) 
grade)) !
.))! "
Value))" '
,))' (
Date** 
=** 
grade**  
.**  !
Date**! %
}++ 
)++ 
;++ 
},, 
var.. 
absences.. 
=.. 
await..  
absensesRepository..! 3
...3 4#
GetAbsencesStudentAsync..4 K
(..K L
student..L S
...S T
Id..T V
)..V W
;..W X
List00 
<00 
AbsenceDataDTO00 
>00  
absenceDatas00! -
=00. /
new000 3
List004 8
<008 9
AbsenceDataDTO009 G
>00G H
(00H I
)00I J
;00J K
foreach22 
(22 
Absence22 
absence22 #
in22$ &
absences22' /
)22/ 0
{220 1
absenceDatas33 
.33 
Add33  
(33  !
new33! $
AbsenceDataDTO33% 3
{333 4
Id44 
=44 
absence44  
.44  !
Id44! #
,44# $
Subject55 
=55 
(55 
await55 $
subjectsRepository55% 7
.557 8
GetSubjectAsync558 G
(55G H
absence55H O
.55O P
Subject55P W
)55W X
)55X Y
.55Y Z
Title55Z _
,55_ `
excused66 
=66 
absence66 %
.66% &
excused66& -
,66- .

motivation77 
=77  
absence77! (
.77( )

motivation77) 3
,773 4
Date88 
=88 
absence88 "
.88" #
Date88# '
}99 
)99 
;99 
}:: 
var<< 
assignments<< 
=<< 
await<< #!
assignmentsRepository<<$ 9
.<<9 :&
GetAssignmentsStudentAsync<<: T
(<<T U
student<<U \
.<<\ ]
Id<<] _
)<<_ `
;<<` a
List>> 
<>> 
AssignmentDataDTO>> "
>>>" #
assignmentDatas>>$ 3
=>>4 5
new>>6 9
List>>: >
<>>> ?
AssignmentDataDTO>>? P
>>>P Q
(>>Q R
)>>R S
;>>S T
foreach@@ 
(@@ 

Assignment@@ 

assignment@@ )
in@@* ,
assignments@@- 8
)@@8 9
{@@9 :
assignmentDatasAA 
.AA  
AddAA  #
(AA# $
newAA$ '
AssignmentDataDTOAA( 9
{AA9 :
IdBB 
=BB 

assignmentBB #
.BB# $
IdBB$ &
,BB& '
StudentCC 
=CC 

assignmentCC (
.CC( )
StudentCC) 0
,CC0 1
SubjectDD 
=DD 
(DD 
awaitDD $
subjectsRepositoryDD% 7
.DD7 8
GetSubjectAsyncDD8 G
(DDG H

assignmentDDH R
.DDR S
SubjectDDS Z
)DDZ [
)DD[ \
.DD\ ]
TitleDD] b
,DDb c
DoneEE 
=EE 

assignmentEE %
.EE% &
DoneEE& *
,EE* +
DateFromFF 
=FF 

assignmentFF )
.FF) *
DateFromFF* 2
,FF2 3
DateDueGG 
=GG 

assignmentGG (
.GG( )
DateDueGG) 0
}HH 
)HH 
;HH 
}II 
returnKK 
studentKK 
.KK 
AsProfileDtoKK '
(KK' (
	gradesDtoKK( 1
,KK1 2
absenceDatasKK3 ?
,KK? @
assignmentDatasKKA P
)KKP Q
;KKQ R
}LL 	
}MM 
}NN ä
gD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Settings\JwtConfig.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
Settings! )
{ 
public 

class 
	JwtConfig 
{ 
public 
string 
Key 
{ 
get 
; 
set  #
;# $
}$ %
public 
string 
Issuer 
{ 
get !
;! "
set# &
;& '
}' (
} 
} √
mD:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Settings\MongoDbSettings.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
.  !
Settings! )
{ 
public 

class 
MongoDbSettings  
{  !
public 
string 
URL 
{ 
get 
; 
set  #
;# $
}$ %
public 
string 
ConnectionString &
{ 	
get 
{ 
return		 
URL		 
;		 
}

 
} 	
} 
} B
\D:\.net\tales-of-a-fourth-grade\Project\TalesOfAForthGrade\TalesOfAForthGrade.Api\Startup.cs
	namespace 	
TalesOfAForthGrade
 
. 
Api  
{ 
public 

class 
Startup 
{ 
public 
Startup 
( 
IConfiguration %
configuration& 3
)3 4
{ 	
Configuration 
= 
configuration )
;) *
} 	
public 
IConfiguration 
Configuration +
{, -
get. 1
;1 2
}3 4
public   
void   
ConfigureServices   %
(  % &
IServiceCollection  & 8
services  9 A
)  A B
{!! 	
services## 
.## 
AddCors## 
(## 
options## $
=>##% '
{$$ 
options%% 
.%% 
	AddPolicy%% !
(%%! "
name%%" &
:%%& '
$str%%( +
,%%+ ,
builder&&  '
=>&&( *
{''  !
builder(($ +
.((+ ,
WithOrigins((, 7
(((7 8
$str((8 P
,((P Q
$str))8 O
,))O P
$str**8 ;
)**; <
.++, -
WithHeaders++- 8
(++8 9
HeaderNames++9 D
.++D E
ContentType++E P
,++P Q
HeaderNames++R ]
.++] ^
Authorization++^ k
)++k l
.,,, -
WithMethods,,- 8
(,,8 9
$str,,9 >
,,,> ?
$str,,@ F
,,,F G
$str,,H M
,,,M N
$str,,O W
,,,W X
$str,,Y b
),,b c
;,,c d
}--  !
)--! "
;--" #
}.. 
).. 
;.. 
BsonSerializer00 
.00 
RegisterSerializer00 -
(00- .
new00. 1
GuidSerializer002 @
(00@ A
BsonType00A I
.00I J
String00J P
)00P Q
)00Q R
;00R S
services22 
.22 
AddSingleton22 !
<22! "
IMongoClient22" .
>22. /
(22/ 0
ServiceProvider220 ?
=>22@ B
{22C D
var33 
settings33 
=33 
Configuration33 +
.33+ ,

GetSection33, 6
(336 7
nameof337 =
(33= >
MongoDbSettings33> M
)33M N
)33N O
.33O P
Get33P S
<33S T
MongoDbSettings33T c
>33c d
(33d e
)33e f
;33f g
return44 
new44 
MongoClient44 %
(44% &
settings44& .
.44. /
ConnectionString44/ ?
)44? @
;44@ A
}55 
)55 
;55 
services66 
.66 
AddSingleton66 !
<66! "
IStudentsRepository66" 5
,665 6$
MongoDbStudentRepository667 O
>66O P
(66P Q
)66Q R
;66R S
services77 
.77 
AddSingleton77 !
<77! " 
IProfessorRepository77" 6
,776 7&
MongoDbProfessorRepository778 R
>77R S
(77S T
)77T U
;77U V
services88 
.88 
AddSingleton88 !
<88! "
IGradesRepository88" 3
,883 4#
MongoDbGradesRepository885 L
>88L M
(88M N
)88N O
;88O P
services99 
.99 
AddSingleton99 !
<99! "
ISubjectsRepository99" 5
,995 6$
MongoDbSubjectRepository997 O
>99O P
(99P Q
)99Q R
;99R S
services:: 
.:: 
AddSingleton:: !
<::! "
IAbsensesRepository::" 5
,::5 6%
MongoDbAbsensesRepository::7 P
>::P Q
(::Q R
)::R S
;::S T
services;; 
.;; 
AddSingleton;; !
<;;! ""
IAssignmentsRepository;;" 8
,;;8 9'
MongoDbAssignmentRepository;;: U
>;;U V
(;;V W
);;W X
;;;X Y
services== 
.== 
AddControllers== #
(==# $
options==$ +
=>==, .
{==/ 0
options>> 
.>> ,
 SuppressAsyncSuffixInActionNames>> 8
=>>9 :
false>>; @
;>>@ A
}?? 
)?? 
;?? 
services@@ 
.@@ 
AddSwaggerGen@@ "
(@@" #
c@@# $
=>@@% '
{AA 
cBB 
.BB 

SwaggerDocBB 
(BB 
$strBB !
,BB! "
newBB# &
OpenApiInfoBB' 2
{BB3 4
TitleBB5 :
=BB; <
$strBB= Q
,BBQ R
VersionBBS Z
=BB[ \
$strBB] a
}BBb c
)BBc d
;BBd e
}CC 
)CC 
;CC 
servicesEE 
.EE 
AddAuthenticationEE &
(EE& '
authEE( ,
=>EE, .
{FF 
authGG 
.GG %
DefaultAuthenticateSchemeGG .
=GG/ 0
JwtBearerDefaultsGG1 B
.GGB C 
AuthenticationSchemeGGC W
;GGW X
authHH 
.HH "
DefaultChallengeSchemeHH +
=HH, -
JwtBearerDefaultsHH. ?
.HH? @ 
AuthenticationSchemeHH@ T
;HHT U
}II 
)II 
.II 
AddJwtBearerII 
(II 
optionsII #
=>II$ &
{JJ 
optionsKK 
.KK %
TokenValidationParametersKK 1
=KK2 3
newKK4 7%
TokenValidationParametersKK8 Q
{LL 
ValidateIssuerMM "
=MM# $
trueMM% )
,MM) *
ValidateAudienceNN $
=NN% &
trueNN' +
,NN+ ,
ValidateLifetimeOO $
=OO% &
trueOO' +
,OO+ ,$
ValidateIssuerSigningKeyPP ,
=PP- .
truePP/ 3
,PP3 4
ValidIssuerQQ 
=QQ  !
ConfigurationQQ" /
[QQ/ 0
$strQQ0 <
]QQ< =
,QQ= >
ValidAudienceRR !
=RR" #
ConfigurationRR$ 1
[RR1 2
$strRR2 >
]RR> ?
,RR? @
IssuerSigningKeySS $
=SS% &
newSS' * 
SymmetricSecurityKeySS+ ?
(SS? @
EncodingSS@ H
.SSH I
UTF8SSI M
.SSM N
GetBytesSSN V
(SSV W
ConfigurationSSW d
[SSd e
$strSSe n
]SSn o
)SSo p
)SSp q
}TT 
;TT 
}UU 
)UU 
;UU 
}WW 	
publicZZ 
voidZZ 
	ConfigureZZ 
(ZZ 
IApplicationBuilderZZ 1
appZZ2 5
,ZZ5 6
IWebHostEnvironmentZZ7 J
envZZK N
)ZZN O
{[[ 	
if\\ 
(\\ 
env\\ 
.\\ 
IsDevelopment\\ !
(\\! "
)\\" #
)\\# $
{]] 
app^^ 
.^^ %
UseDeveloperExceptionPage^^ -
(^^- .
)^^. /
;^^/ 0
app__ 
.__ 

UseSwagger__ 
(__ 
)__  
;__  !
app`` 
.`` 
UseSwaggerUI``  
(``  !
c``! "
=>``# %
c``& '
.``' (
SwaggerEndpoint``( 7
(``7 8
$str``8 R
,``R S
$str``T k
)``k l
)``l m
;``m n
}aa 
appcc 
.cc 
UseHttpsRedirectioncc #
(cc# $
)cc$ %
;cc% &
appee 
.ee 
UseAuthenticationee !
(ee! "
)ee" #
;ee# $
appff 
.ff 

UseRoutingff 
(ff 
)ff 
;ff 
appgg 
.gg 
UseCorsgg 
(gg 
$strgg 
)gg 
;gg 
apphh 
.hh 
UseAuthorizationhh  
(hh  !
)hh! "
;hh" #
appjj 
.jj 
UseEndpointsjj 
(jj 
	endpointsjj &
=>jj' )
{kk 
	endpointsll 
.ll 
MapControllersll (
(ll( )
)ll) *
;ll* +
}mm 
)mm 
;mm 
}nn 	
}oo 
}pp 