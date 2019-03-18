**free

ctl-opt nomain;

/include shiftcpy

dcl-proc aktualisiereSchichtZuweisung export;
       dcl-pi aktualisiereSchichtZuweisung;
         uuid      char(4);
         shift     char(5);
         day       date;
       end-pi;
       dcl-s hv2   char(6);
       dcl-s hv3   char(256);

       exec sql set option commit=*none;

       exec sql merge into dplanshift as ds
         using (values(:shift, :uuid, :day)) as rec(shift, uuid, day)
         on ds.shift = rec.shift and ds.day = rec.day
         when matched then update set ds.uuid = rec.uuid
         when not matched then
           insert (uuid, shift, day)
           values(rec.uuid, rec.shift, rec.day);

end-proc; 