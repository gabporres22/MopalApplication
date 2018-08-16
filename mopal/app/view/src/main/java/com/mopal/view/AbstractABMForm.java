package com.mopal.view;

import com.mopal.model.Evento;
import com.mopal.model.TipoEvento;
import org.jetbrains.annotations.NotNull;
import tekgenesis.form.Action;

import static com.mopal.model.TipoEvento.*;
import static com.mopal.model.g.EventoBase.findWhere;
import static com.mopal.model.g.EventoTable.EVENTO;

/** User class for form: AbstractABMForm */
public class AbstractABMForm extends AbstractABMFormBase {
    @NotNull
    @Override
    public Action redirect() {
        final Evento evento = findWhere(EVENTO.ACTIVO.eq(true));

        if(evento != null){
            if(evento.getTipoEvento() == JORNADA_PENTECOSTES){
                final AsistenteJornadaPentecostesForm jornadaPentecostesForm = forms.initialize(AsistenteJornadaPentecostesForm.class);
                jornadaPentecostesForm.setEvento(evento);
                return actions().navigate(jornadaPentecostesForm);
            } else if (evento.getTipoEvento() == RETIRO_DE_PASCUA) {
                final AsistenteRetiroPascuaForm retiroPascuaForm = forms.initialize(AsistenteRetiroPascuaForm.class);
                retiroPascuaForm.setEvento(evento);
                return actions().navigate(retiroPascuaForm);
            } else if (evento.getTipoEvento() == ASAMBLEA) {
                final AsistenteAsambleaForm asambleaForm = forms.initialize(AsistenteAsambleaForm.class);
                asambleaForm.setEvento(evento);
                return actions().navigate(asambleaForm);
            } else if(evento.getTipoEvento() == JORNADA_MARIA) {
                final AsistenteJornadaMariaForm asistenteJornadaMariaForm = forms.initialize(AsistenteJornadaMariaForm.class);
                asistenteJornadaMariaForm.setEvento(evento);
                return actions().navigate(asistenteJornadaMariaForm);
            }
        }

        return actions().getError().withMessage("No hay un Evento activo");
    }
}
