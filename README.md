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
Zusätzlich wird eine Tabelle für die Schichtzuordnung verwendet
  ```sql
  create table lib.dplanshift (
    uuid          varchar(4),
    shift         varchar(5),
    day           date
  )
  ```
(Diese Tabellen dienen nur dazu, die Grundmechanismen zu zeigen - sie sind kein Beispiel für sinnvolles Datenbankdesign)

## Programm
Erstellen mit folgendem Kommando

```
CRTSQLRPGI OBJ(LIB/SHIFT)
  SRCFILE(LIB/QRPGLESRC) 
  SRCMBR(SHIFT) 
  OBJTYPE(*MODULE) 
  OPTION(*EVENTF) 
  RPGPPOPT(*LVL2) 
  REPLACE(*YES) 
  DBGVIEW(*SOURCE)

CRTSQLRPGI OBJ(LIB/DPLAN85) 
  SRCFILE(LIB/QRPGLESRC) 
  SRCMBR(DPLAN85) 
  OBJTYPE(*MODULE) 
  OPTION(*EVENTF) 
  RPGPPOPT(*LVL2) 
  REPLACE(*YES) 
  DBGVIEW(*SOURCE)

CRTPGM PGM(LIB/DPLAN85)
  MODULE(LIB/DPLAN85 LIB/SHIFT)
  BNDSRVPGM((LIB/VVSRVPGM))
  BNDDIR(LIB/VVSRVPGM)
```

