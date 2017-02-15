{$mode objfpc}

unit pallot;

interface

uses
        ptcgraph;

type
	TVektori = record
		x : real;
		y : real;
	end;

	Tpallo = class
		private
			paikka : TVektori;
			nopeus : TVektori;
			sade : real;

		public
			constructor Create(x, y, v1, v2, r : real); overload;
			constructor Create(xy, v : TVektori; r : real); overload;

			procedure SetPaikka(xy : TVektori); overload;
			procedure SetPaikka(x, y : real); overload;
			function GetPaikka : TVektori;

			procedure SetNopeus(v : TVektori); overload;
			procedure SetNopeus(x, y : real); overload;
			function GetNopeus : TVektori;

                        procedure SetSade(r : real);
                        function GetSade : real;

			procedure liikuta;
			procedure piirra;
	end;

function normi(v : TVektori) : real;

operator + (v, u : TVektori) w : TVektori;
operator - (v, u : TVektori) w : TVektori;
operator * (x : real; v : TVektori) w : TVektori;

procedure tormays(a, b : Tpallo);

implementation

function normi(v: TVektori) : real;
begin
        normi := sqrt(v.x*v.x + v.y*v.y);
end;

operator + (v, u : TVektori) w : TVektori;
begin
        w.x := v.x + u.x;
        w.y := v.y + u.y;
end;

operator - (v, u : TVektori) w : TVektori;
begin
        w.x := v.x - u.x;
        w.y := v.y - u.y;
end;

operator * (x : real; v : TVektori) w : TVektori;
begin
        w.x := x*v.x;
        w.y := x*v.y;
end;

constructor Tpallo.Create(x, y, v1, v2, r : real);
begin
        paikka.x := x;
        paikka.y := y;
        nopeus.x := v1;
        nopeus.y := v2;
        sade := r;
end;

constructor Tpallo.Create(xy, v : TVektori; r : real);
begin
        paikka := xy;
        nopeus := v;
        sade := r;
end;

procedure Tpallo.SetPaikka(xy : TVektori);
begin
        paikka := xy;
end;

procedure Tpallo.SetPaikka(x, y : real);
begin
        paikka.x := x;
        paikka.y := y;
end;

function Tpallo.GetPaikka : TVektori;
begin
        GetPaikka := paikka;
end;

procedure Tpallo.SetNopeus(v : TVektori);
begin
        nopeus := v;
end;

procedure Tpallo.SetNopeus(x, y : real);
begin
        nopeus.x := x;
        nopeus.y := y;
end;

function Tpallo.GetNopeus : TVektori;
begin
        GetNopeus := nopeus;
end;

procedure Tpallo.liikuta;
begin
        paikka := paikka + nopeus;
end;

procedure Tpallo.piirra;
begin
        FillEllipse(round(paikka.x), round(paikka.y), round(sade), round(sade));
end;

procedure Tpallo.SetSade(r : real);
begin
        sade := r;
end;

function Tpallo.GetSade : real;
begin
        GetSade := sade;
end;

procedure tormays(a, b : Tpallo);
var
  erotus, taso, uusiXa, uusiYa, uusiXb, uusiYb : TVektori;
begin
        erotus := b.GetPaikka - a.GetPaikka;
        taso.x := erotus.y;
        taso.y := -erotus.x;
        uusiXa := ((1/(normi(taso)*normi(taso)))*(a.getNopeus.x*taso.x + a.getNopeus.y*taso.y)) * taso;
        uusiYa := a.getNopeus - uusiXa;
        uusiXb := ((1/(normi(taso)*normi(taso)))*(b.getNopeus.x*taso.x + b.getNopeus.y*taso.y)) * taso;
        uusiYb := b.getNopeus - uusiXb;
        a.setNopeus(a.getNopeus - uusiYa + uusiYb);
        b.setNopeus(b.getNopeus - uusiYb + uusiYa);
end;

end.
