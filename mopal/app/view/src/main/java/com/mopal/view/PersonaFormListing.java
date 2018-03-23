package com.mopal.view;


import com.mopal.model.Comunidad;
import com.mopal.model.Localidad;
import com.mopal.model.Nivel;
import com.mopal.model.Persona;
import com.mopal.model.g.PersonaBase;
import org.jetbrains.annotations.NotNull;
import tekgenesis.common.collections.ImmutableList;
import tekgenesis.common.core.DateOnly;
import tekgenesis.common.core.Option;
import tekgenesis.form.Action;
import tekgenesis.form.MappingCallback;
import tekgenesis.persistence.Criteria;

import static com.mopal.model.g.PersonaTable.PERSONA;
import static tekgenesis.common.core.Option.option;

/** User class for form: PersonaFormListing */
public class PersonaFormListing
    extends PersonaFormListingBase
{

    @NotNull
    @Override
    public Action updateComunidadFiltro() {
        if(! option(getNivelFiltro()).isPresent() || (option(getNivelFiltro()).isPresent() && getNivelFiltro().equals(Nivel.NINGUNA)))
            setComunidadFiltro(null);

        return actions.getDefault();
    }

    @NotNull
    @Override
    public Action buscar() {
        getPersonas().clear();

        obtenerPersonasFiltro(option(getNombreFiltro()), option(getApellidoFiltro()), option(getLocalidadFiltro()), option(getNivelFiltro()), option(getComunidadFiltro())).forEach(
                persona -> getPersonas().add().populate(persona)
        );

        return actions.getDefault();
    }

    @NotNull
    @Override
    public Action resetearFiltros() {
        getPersonas().clear();
        loadPersonas();
        return actions.getStay();
    }

    private Boolean isFilterPresent() {
        return option(getNombreFiltro()).isPresent() || option(getApellidoFiltro()).isPresent() || option(getLocalidadFiltro()).isPresent() || option(getNivelFiltro()).isPresent()|| option(getComunidadFiltro()).isPresent();
    }

    @NotNull
    @Override
    public Action addPersona() {
        return actions().navigate(PersonaForm.class).callback(PersonaFormMapping.class);
    }

    private ImmutableList<Persona> obtenerPersonasFiltro(final Option<String> nombre, final Option<String> apellido, final Option<Localidad> localidad, final Option<Nivel> nivel, final Option<Comunidad> comunidad) {
        final Criteria nombreCriteria = nombre.isPresent() ? PERSONA.NOMBRE.contains(nombre.get()) : Criteria.EMPTY;
        final Criteria apellidoCriteria = apellido.isPresent() ? PERSONA.APELLIDO.contains(apellido.get()) : Criteria.EMPTY;
        final Criteria localidadCriteria = localidad.isPresent() ? PERSONA.LOCALIDAD_ID.eq(localidad.get().getId()) : Criteria.EMPTY;
        final Criteria nivelCriteria = nivel.isPresent() ? PERSONA.NIVEL.eq(nivel.get()) : Criteria.EMPTY;
        final Criteria comunidadCriteria = comunidad.isPresent() && nivel.isPresent() && !nivel.get().equals(Nivel.NINGUNA) ? PERSONA.COMUNIDAD_ID.eq(comunidad.get().getId()) : Criteria.EMPTY;

        return PersonaBase.listWhere(nombreCriteria.and(apellidoCriteria.and(localidadCriteria.and(nivelCriteria).and(comunidadCriteria)))).toList();
    }

    public class PersonasRow extends PersonasRowBase {
        @NotNull
        @Override
        public Action editarPersona() {
            final PersonasRow current = getPersonas().getCurrent();
            final PersonaForm newForm = forms.initialize(PersonaForm.class, String.valueOf(current.getId()));
            forms.asUpdate();
            return actions.navigate(newForm).callback(PersonaFormMapping.class);
        }

        @Override
        public void populate(@NotNull Persona persona) {
            super.populate(persona);
            setEdad(DateOnly.current().yearsFrom(persona.getFechaNacimiento()));
            if(persona.getNivel().equals(Nivel.NINGUNA))
                setComunidad("");
            else
                setComunidad(persona.getComunidad().getDescripcion() + " (" + persona.getComunidad().getLocalidad() + ")");
        }
    }

    public static class PersonaFormMapping implements MappingCallback<PersonaForm, PersonaFormListing> {
        @Override
        public void onSave(@NotNull PersonaForm base, @NotNull PersonaFormListing out) {
            if(out.isFilterPresent()){
                out.buscar();
            } else {
                out.getPersonas().clear();
                out.loadPersonas();
            }
        }
    }
}
