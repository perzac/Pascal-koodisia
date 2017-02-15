program PallotOlioina;

uses
        pallot, ptcgraph, ptccrt;

const
        leveys = 800;
        korkeus = 800;
        sade = 100;
        vauhti : real = 5;

var
        TmpNopeus : TVektori;
        TmpPaikka : TVektori;
        suunta : real;
        pallo1 : Tpallo;
        pallo2 : Tpallo;
        gd, gm : Smallint;

begin
        randomize;

        TmpPaikka.x := Random(leveys - 2*sade) + sade;
        TmpPaikka.y := Random(korkeus - 2*sade) + sade;
        suunta := Pi*real(Random(360))/180;
        TmpNopeus.x := cos(suunta)*vauhti;
        TmpNopeus.y := -sin(suunta)*vauhti;
        pallo1 := Tpallo.Create(TmpPaikka, TmpNopeus, real(sade));

        { Tässä kohdassa toistetaan niin kauan, että toista palloa ei luoda
          ensimmäinen sisään. }
        repeat
                TmpPaikka.x := Random(leveys - 2*sade) + sade;
                TmpPaikka.y := Random(korkeus - 2*sade) + sade
        until (normi(pallo1.GetPaikka - TmpPaikka) >= 2*sade);
        suunta := Pi*real(Random(360))/180;
        TmpNopeus.x := cos(suunta)*vauhti;
        TmpNopeus.y := -sin(suunta)*vauhti;
        pallo2 := Tpallo.Create(TmpPaikka, TmpNopeus, real(sade));

        gd := detect;
        gm := 0;
        InitGraph(gd, gm, '');

        Rectangle(99, 99, 101 + leveys, 101 + korkeus);
        SetViewPort(100, 100, 100 + leveys, 100 + korkeus, true);

        repeat
                if (pallo1.GetPaikka.x + pallo1.GetNopeus.x <= sade) or (pallo1.GetPaikka.x + pallo1.GetNopeus.x >= leveys - sade) then pallo1.SetNopeus(-pallo1.GetNopeus.x, pallo1.GetNopeus.y);
                if (pallo1.GetPaikka.y + pallo1.GetNopeus.y <= sade) or (pallo1.GetPaikka.y + pallo1.GetNopeus.y >= korkeus - sade) then pallo1.SetNopeus(pallo1.GetNopeus.x, -pallo1.GetNopeus.y);
                if (pallo2.GetPaikka.x + pallo2.GetNopeus.x <= sade) or (pallo2.GetPaikka.x + pallo2.GetNopeus.x >= leveys - sade) then pallo2.SetNopeus(-pallo2.GetNopeus.x, pallo2.GetNopeus.y);
                if (pallo2.GetPaikka.y + pallo2.GetNopeus.y <= sade) or (pallo2.GetPaikka.y + pallo2.GetNopeus.y >= korkeus - sade) then pallo2.SetNopeus(pallo2.GetNopeus.x, -pallo2.GetNopeus.y);

                if (normi(pallo2.GetPaikka + pallo2.GetNopeus - pallo1.GetPaikka - pallo1.GetNopeus) <= 2*sade) then tormays(pallo1, pallo2);

                pallo1.liikuta;
                pallo2.liikuta;

                ClearViewPort;
                pallo1.piirra;
                pallo2.piirra;
                Delay(5)
        until KeyPressed;
        ReadKey;

        CloseGraph;
end.

















