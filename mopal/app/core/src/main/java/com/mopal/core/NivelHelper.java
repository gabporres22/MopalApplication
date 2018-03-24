package com.mopal.core;
import com.mopal.model.Nivel;

import static com.mopal.model.g.NivelBase.findWhere;
import static com.mopal.model.g.NivelTable.NIVEL;

public class NivelHelper {
    private static NivelHelper ourInstance = new NivelHelper();

    public static NivelHelper getInstance() {
        return ourInstance;
    }

    private NivelHelper() {
    }

    public static Nivel getNivelNinguno(){
        return findWhere(NIVEL.DESCRIPCION.eq("NINGUNA"));
    }
}
