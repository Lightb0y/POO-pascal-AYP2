unit URandomGenerator;
{$mode objfpc}

interface
uses UDateTime, GenericLinkedList;

type

	RandomGenerator = class
		type
			Lista = specialize LinkedList<string>;
			
		private
		    first: boolean; static ;
			labels: Lista;
			cantLabels: integer;
			
			function between(min, max: Date; m, a: integer): boolean;
			function between(min, max: Date; d, m, a: integer): boolean;
			function between(min, max: Time; m, h: integer): boolean;
			function between(min, max: Time; s, m, h: integer): boolean;
			
		public
			constructor create();
			
			function getInteger(min, max: integer): integer;
			function getReal(min, max: real): real;
			function getString(cantCaracteres: integer): string;
			function getBoolean(): boolean;
			function getDate(min, max: Date): Date;
			function getTime(min, max: Time): Time;
			procedure addLabel(lab: string);	
			function getLabel(): string;		
			procedure clearLabels();
	end;	
	
implementation

	function RandomGenerator.between(min, max: Date; m, a: integer): boolean;
	var ok: boolean;
	begin
	ok:= true;
	if (min.getYear() = a) and (m < min.getMonth()) then ok:= false;
	if (max.getYear() = a) and (m > max.getMonth()) then ok:= false;
	between:= ok;
	end;
	
	function RandomGenerator.between(min, max: Date; d, m, a: integer): boolean;
	var ok: boolean;
	begin
	ok:= true;
	if (min.getYear() = a) and (min.getMonth() = m) and (d < min.getDay()) then ok:= false;
	if (max.getYear() = a) and (max.getMonth() = m) and (d > max.getDay()) then ok:= false;
	between:= ok;
	end;
			
	function RandomGenerator.between(min, max: Time; m, h: integer): boolean;
	var ok: boolean;
	begin
	ok:= true;
	if (min.getHour() = h) and (m < min.getMinutes()) then ok:= false;
	if (max.getHour() = h) and (m > max.getMinutes()) then ok:= false;
	between:= ok;
	end;
	
	function RandomGenerator.between(min, max: Time; s, m, h: integer): boolean;
    var ok: boolean;
	begin
	ok:= true;
	if (min.getHour() = h) and (min.getMinutes() = m) and (s < min.getSeconds()) then ok:= false;
	if (max.getHour() = h) and (max.getMinutes() = m) and (s > max.getSeconds()) then ok:= false;
	between:= ok;
	end;
	
    constructor RandomGenerator.create();
    begin
    if first then begin
		randomize;
		first:= false;
	end;
    labels:= Lista.create();
    cantLabels:= 0;
    end;
			
	function RandomGenerator.getInteger(min, max: integer): integer;
	begin
	getInteger:= random(max - min + 1) + min;
	end;
			
	function RandomGenerator.getReal(min, max: real): real;
	begin
	getReal:= random() * (max - min) + min;
	end;
	
	function RandomGenerator.getString(cantCaracteres: integer): string;
	var s: string;
		i: integer;
	begin
	s:= '';
	for i:= 1 to cantCaracteres do
	  begin
	  s:= s + chr(random(122 - 97 + 1) + 97); 
	  end;
	getString:= s;
	end;
			
	function RandomGenerator.getBoolean(): boolean;
	begin
	getBoolean:= random() > 0.5;
	end;
	
	function RandomGenerator.getDate(min, max: Date): Date;
	var d, m, a: integer;
	begin
	a:= random(max.getYear() - min.getYear() + 1) + min.getYear();
	
	repeat
		m:= random(12) + 1;
	until between(min, max, m, a);
	
	repeat
		d:= random(31) + 1;
	until between(min, max, d, m, a);
	
	getDate:= Date.create(d, m, a);
	end;
			
	function RandomGenerator.getTime(min, max: Time): Time;
	var h, m, s: integer;
	begin
	h:= random(max.getHour() - min.getHour() + 1) + min.getHour();
	
	repeat
		m:= random(60);
	until between(min, max, m, h);
	
	repeat
		s:= random(60);
	until between(min, max, s, m, h);
	
	getTime:= Time.create(h, m, s);
	end;
	
	procedure RandomGenerator.addLabel(lab: string);
	begin
	labels.add(lab);
	cantLabels:= cantLabels + 1;
	end;	
			
	function RandomGenerator.getLabel(): string;
	var i: integer;
	begin
	if cantLabels = 0 then
	  getLabel:= ''
	else
	  begin
	  i:= random(cantLabels);
	  labels.reset();
	  while i > 0 do
		begin
		labels.next();
		i:= i - 1;
		end;
	  getLabel:= labels.current();
	  end;
	end;
	
	procedure RandomGenerator.clearLabels();
	begin
	labels.reset();
	while not labels.eol() do
	  labels.removeCurrent();
	cantLabels:= 0;
	end;

begin
RandomGenerator.first:= true;				
end.
