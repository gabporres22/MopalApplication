package com.mopal.model;

import com.mopal.model.g.AsistenteJornadaMariaBase;
import tekgenesis.common.collections.ImmutableList;

import static com.mopal.model.g.PRJornadaMariaTable.PRJORNADA_MARIA;

/** User class for Model: AsistenteJornadaMaria */
public class AsistenteJornadaMaria extends AsistenteJornadaMariaBase {
    public ImmutableList<PRJornadaMaria> getPersonasRelacionadas() {
        return PRJornadaMaria.listWhere(
                PRJORNADA_MARIA.PERSONA_RELACIONADA_ID.eq(getId()).or(
                PRJORNADA_MARIA.PERSONA_RELACIONADA2_ID.eq(getId()))
        ).list();
    }
}
