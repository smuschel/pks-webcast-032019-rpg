      /include qcpylesrc,vvHspec
     h ccsid(*graph:65535)
     **-------------------------------------------------------------
     **         Copyright (C) 2008-2018 CNX Corporation
     **-------------------------------------------------------------
     **     Object ID: DPLAN85
     **                (Generated by Valence Nitro Autocode)
     **       Version: V5.2
     **   Description: Dientsplanerstellung
     **-------------------------------------------------------------
     ** Modifications:
     **-------------------------------------------------------------
     ** Mod#  |   Date   | Programmer   |   Description
     ** --------------------------------------------------------------
     **-------------------------------------------------------------
     **  d specs
     **-------------------------------------------------------------
     d action          s             20a

     ** internal Procedures...
     d*

      /include qcpylesrc,vvDspec
      /include shiftcpy

     **-------------------------------------------------------------
     **  program start
     **-------------------------------------------------------------
      /free
       exec sql set option commit=*none, datfmt=*ISO;
       action=vvIn_char('action');

       select;
       when action='getTeam';
         getTeam();
       when action='getShifts';
         getShifts();
       when action='schichtZuweisen';
         zuweisen();
       other;
         vvOut_toJSONpair('success:false,msg:Invalid action':
                          *omit:*omit:*omit:*off);
       endsl;
       *inlr=*on;
      /end-free

     **-------------------------------------------------------------
     p zuweisen        b
     p* Teammitglied für bestimmte Schicht zuweisen
     d                 pi
     d*
     d stmt            s           4096a   varying
     d uuid            s              4a
     d shift           s              5a
     d day             s               d   inz(d'2015-02-25')
     d

      /free

       uuid = vvIn_char('wer');
       shift = vvIn_char('schicht');
       day = vvIn_date('date':'*ISO');
       aktualisiereSchichtZuweisung(uuid:shift:day);
       vvOut_toJSONpair('success:true');
      /end-free
     p                 e



     **-------------------------------------------------------------
     p getTeam         b
     p* Load a page of records for the grid
     d                 pi
     d*
     d stmt            s           4096a   varying
     d col             ds                  likeDS(vvSSCol)
     d                                     dim(3) inz

      /free
       stmt = 'select * from dplanteam';

       vvOut.applySorters= '1';
       vvOut.singleRow   = '0';
       vvOut.rootName    = 'recs';
       vvOut.success     = 'true';
       vvOut.applyPaging = '1';
       vvOut_execSQLtoJSON(vvOut:stmt);
      /end-free
     p                 e

     **-------------------------------------------------------------
     p getShifts       b
     p* Load a page of records for the grid
     d                 pi
     d*
     d stmt            s           4096a   varying
     d day             s               d   inz(d'2015-02-25')
     d
      /free
       day = vvIn_date('date':'*ISO');
       stmt = 'select * from dplanshift where day = ' +
         SQ + %char(day) + SQ;

       vvOut.applySorters= '1';
       vvOut.singleRow   = '0';
       vvOut.rootName    = 'recs';
       vvOut.success     = 'true';
       vvOut.applyPaging = '1';
       vvOut_execSQLtoJSON(vvOut:stmt);
      /end-free
     p                 e 