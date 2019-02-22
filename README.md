# pks-webcast-032019-rpg
Sourcen für den PKS Webcast am 19.03.2019 - RPG

## Datenbank
Das Programm erwartet eine Datenbanktabelle in der Lib-Liste (Valence Environment) mit folgender Struktur:

  ```sql
  create table lib.dplanteam (
    name          varchar(32), 
    description   varchar(64), 
    state         varchar(8), 
    uuid          varchar(4)
  ) 
  ```
                                                                      
## Programm
Erstellen mit folgendem Kommando

```
CRTSQLRPGI OBJ(LIB/DPLAN85) 
  SRCFILE(LIB/QRPGLESRC) 
  SRCMBR(DPLAN85) 
  OPTION(*EVENTF) 
  RPGPPOPT(*LVL2)
  REPLACE(*YES) 
  DBGVIEW(*SOURCE)
```

Wichtig ist die Angabe von RPGPPOPT(*LVL2)
