package com.mopal.view;

import com.mopal.core.NivelHelper;
import com.mopal.model.Barrio;
import com.mopal.model.Comunidad;
import com.mopal.model.Persona;
import com.mopal.model.PersonaRelacionada;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;
import tekgenesis.common.core.DateOnly;
import tekgenesis.form.Action;
import tekgenesis.form.MappingCallback;

import static tekgenesis.common.core.DateOnly.current;

/** User class for form: PersonaForm */
public class PersonaForm extends PersonaFormBase {
    @NotNull
    @Override
    public Persona populate() {
        final Persona persona = super.populate();
        actualizarEdad();
        return persona;
    }

    @Override
    public void load() {
        super.load();
        setNivelNinguno(NivelHelper.getNivelNinguno());
    }

    @NotNull
    @Override
    public Action createBarrio(@Nullable String text) {
        final BarrioForm newForm = forms.initialize(BarrioForm.class);

        newForm.setDisableLocalidad(true);
        newForm.setLocalidad(getLocalidad());

        return actions().navigate(newForm).callback(BarrioFormMapping.class);
    }

    private void actualizarEdad() {
        setEdadValue(String.valueOf(current().yearsFrom(getFechaNacimiento())) + " años");
    }

    @NotNull
    @Override
    public Action updateEdad() {
        actualizarEdad();
        return actions().getDefault();
    }

    @NotNull
    @Override
    public Action createComunidad(@Nullable String text) {
        final ComunidadForm newForm = forms.initialize(ComunidadForm.class);

        newForm.setDisableNivel(true);
        newForm.setNivelComunidad(getNivel());

        return actions().navigate(newForm).callback(ComunidadFormMapping.class);
    }

    @NotNull
    @Override
    public Action addPersonaRelacionada() {
        final PersonaRelacionadaForm form = forms.initialize(PersonaRelacionadaForm.class);
        form.setPersona(Persona.find(getId()));
        return actions().navigate(form).callback(PersonaRelacionadaFormMapping.class);
    }

    public static class ComunidadFormMapping implements MappingCallback<ComunidadForm, PersonaForm> {
        @Override
        public void onSave(@NotNull ComunidadForm base, @NotNull PersonaForm out) {
            final Comunidad comunidad = Comunidad.find(base.getId());
            out.setComunidad(comunidad);
        }
    }

    public static class BarrioFormMapping implements MappingCallback<BarrioForm, PersonaForm> {
        @Override
        public void onSave(@NotNull BarrioForm base, @NotNull PersonaForm out) {
            final Barrio barrio = Barrio.find(base.getId());
            out.setBarrio(barrio);
        }
    }

    public static class PersonaRelacionadaFormMapping implements MappingCallback<PersonaRelacionadaForm, PersonaForm> {
        @Override
        public void onSave(@NotNull PersonaRelacionadaForm base, @NotNull PersonaForm out) {

        }
    }
}
