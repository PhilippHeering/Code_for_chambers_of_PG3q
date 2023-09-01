LoadPackage("FinInG");
LoadPackage("Grape");

OnFlags := function(flag, g)
    return List(flag, x -> OnProjSubspaces(x,g));
end;

SpaceGroupFlags := function(q)
    local flags, projectivespace, baseplane, baseline, 
        basepoint, baseflag, collineationgroup;
    projectivespace := ProjectiveSpace(3,q);
    collineationgroup := CollineationGroup(projectivespace);
    baseplane := Random(Planes(projectivespace));
    baseline := Random(Lines(baseplane));
    basepoint := Random(Points(baseline));
    baseflag := [basepoint, baseline, baseplane];
    flags := Orbit(collineationgroup, baseflag, OnFlags);
    return [projectivespace, collineationgroup, flags];
end;

OppositeFlags := function(f, g)
    local opposite;
    opposite := true;
    if f[1] in g[3] then
        opposite := false;
    elif g[1] in f[3] then
        opposite := false;
    elif not IsEmptySubspace(Meet(f[2], g[2])) then
        opposite := false;
    fi;
    return opposite;
end;

OppositeGraph := function(q)
    local projectivespace, collineationgroup, flags, 
        spacegroupflags, gamma;
    spacegroupflags := SpaceGroupFlags(q);
    projectivespace := spacegroupflags[1];
    collineationgroup := spacegroupflags[2];
    flags := spacegroupflags[3];
    gamma := Graph(collineationgroup, flags, OnFlags, 
        OppositeFlags, true);
    return gamma;
end;

NonOppositeFlags := function(f, g)
    local nonopposite;
    nonopposite := false;
    if f = g then
        #nothing
    elif f[1] in g[3] then
        nonopposite := true;
    elif g[1] in f[3] then
        nonopposite := true;
    elif not IsEmptySubspace(Meet(f[2], g[2])) then
        nonopposite := true;
    fi;
    return nonopposite;
end;

NonOppositeGraph := function(q)
    local projectivespace, collineationgroup, flags, 
        spacegroupflags, antigamma;
    spacegroupflags := SpaceGroupFlags(q);
    projectivespace := spacegroupflags[1];
    collineationgroup := spacegroupflags[2];
    flags := spacegroupflags[3];
    antigamma := Graph(collineationgroup, flags, OnFlags, 
        NonOppositeFlags, true);
    return antigamma;
end;

SecondMax := function(q)
    local k, searching, antigamma, max;
    antigamma := NonOppositeGraph(q);
    max := CliqueNumber(antigamma);
    Print("The maximal set has size ", max, "\n");
    k := max-1;
    searching := true;
    while searching do
        if CompleteSubgraphsOfGivenSize(antigamma, k, 0, true) = [] 
            then Print("No maximal set of size ", k, "\n");
            k := k-1;
        else
            Print("There is a maximal set of size ");
            return k; 
            searching := false;
        fi;
    od;
end;

ThirdMax := function(q)
    local k, searching, antigamma, max;
    antigamma := NonOppositeGraph(q);
    max := 3*q^3+5*q^2+3*q+1;
    Print("The second largest maximal sets have size ", max, "\n");
    k := max-1;
    searching := true;
    while searching do
        if CompleteSubgraphsOfGivenSize(antigamma, k, 0, true) = [] 
            then Print("No maximal set of size ", k, "\n");
            k := k-1;
        else
            Print("There is a maximal set of size ");
            return k;
            searching := false;
        fi;
    od;
end;

FourthMax := function(q)
    local k, searching, antigamma, max;
    antigamma := NonOppositeGraph(q);
    max := 3*q^3+4*q^2+3*q+2;
    Print("The third largest maximal sets have size ", max, "\n");
    k := max-1;
    searching := true;
    while searching do
        if CompleteSubgraphsOfGivenSize(antigamma, k, 0, true) = []
            then Print("No maximal set of size ", k, "\n");
            k := k-1;
        else
            Print("There is a maximal set of size ");
            return k;
            searching := false;
        fi;
    od;
end;

# create grpahs with G:=OppositeGraph(q) 
# and A:=NonOppositeGraph(q)

# get the cardinality of the second largest maximal sets 
# with the command SecondMax(q)

# get the cardinality of the third largest maximal sets 
# with the command ThirdMax(q)

# get the cardinality of the fourth largest maximal sets
# with the command FourthMax(q)

# get the chromatic number with the command ChromaticNumber(G)

#example for q=2:
#SecondMax(2);
#ThirdMax(2);
#FourthMax(2);
#G:=OppositeGraph(2); 
#ChromaticNumber(G);

