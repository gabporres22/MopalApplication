package com.mopal.view;

import com.mopal.model.*;
import com.mopal.model.g.AsistenteBase;
import com.mopal.model.g.AsistenteJornadaPentecostesBase;
import com.mopal.model.g.EventoBase;
import com.mopal.model.g.EventoTable;
import tekgenesis.common.collections.ImmutableList;
import tekgenesis.common.core.Option;
import tekgenesis.form.Action;
import org.jetbrains.annotations.NotNull;
import tekgenesis.form.MappingCallback;
import tekgenesis.persistence.Criteria;

import java.math.BigDecimal;
import java.util.Comparator;

import static com.mopal.core.NivelHelper.getNivelNinguno;
import static com.mopal.model.TipoEvento.JORNADA_PENTECOSTES;
import static com.mopal.model.g.AsistenteJornadaPentecostesBase.listWhere;
import static com.mopal.model.g.AsistenteJornadaPentecostesTable.ASISTENTE_JORNADA_PENTECOSTES;
import static com.mopal.model.g.AsistenteTable.ASISTENTE;
import static com.mopal.model.g.EventoBase.findWhere;
import static com.mopal.model.g.EventoTable.EVENTO;
import static tekgenesis.common.core.DateOnly.current;
import static tekgenesis.common.core.Option.option;

/** User class for form: AsistenteJornadaPentecostesFormListing */
public class AsistenteJornadaPentecostesFormListing extends AsistenteJornadaPentecostesFormListingBase {
    //~ Methods ..................................................................................................................
    final static Evento evento = findWhere(EVENTO.ACTIVO.eq(true).and(EVENTO.TIPO_EVENTO.eq(JORNADA_PENTECOSTES)));

    private Evento getEvento() {
        return evento;
    }

    /** Invoked when button(buscar) is clicked */
    @Override @NotNull public Action buscar() {
        getAsistentesJornadaPentecostes().clear();

        final ImmutableList<AsistenteJornadaPentecostes> result = obtenerAsistentesFiltro(option(getNombreFiltro()), option(getApellidoFiltro()), option(getLocalidadFiltro()), option(getNivelFiltro()), option(getComunidadFiltro()));
        result.forEach(
            persona -> getAsistentesJornadaPentecostes().add().populate(persona)
        );

        setTotalRows(String.valueOf(result.getSize().getOrFail("0")));

        return actions.getDefault();
    }

    private Boolean isFilterPresent() {
        return option(getNombreFiltro()).isPresent() || option(getApellidoFiltro()).isPresent() || option(getLocalidadFiltro()).isPresent() || option(getNivelFiltro()).isPresent()|| option(getComunidadFiltro()).isPresent();
    }

    private ImmutableList<AsistenteJornadaPentecostes> obtenerAsistentesFiltro(final Option<String> nombre, final Option<String> apellido, final Option<Localidad> localidad, final Option<Nivel> nivel, final Option<Comunidad> comunidad) {
        final Criteria eventoCriteria = EVENTO.ID.eq(getEvento().getId());
        final Criteria nombreCriteria = nombre.isPresent() ? ASISTENTE.NOMBRE.contains(nombre.get()) : Criteria.EMPTY;
        final Criteria apellidoCriteria = apellido.isPresent() ? ASISTENTE.APELLIDO.contains(apellido.get()) : Criteria.EMPTY;
        final Criteria localidadCriteria = localidad.isPresent() ? ASISTENTE.LOCALIDAD_ID.eq(localidad.get().getId()) : Criteria.EMPTY;
        final Criteria nivelCriteria = nivel.isPresent() ? ASISTENTE.NIVEL_ID.eq(nivel.get().getId()) : Criteria.EMPTY;
        final Criteria comunidadCriteria = comunidad.isPresent() && nivel.isPresent() && !nivel.get().equals(getNivelNinguno()) ? ASISTENTE.COMUNIDAD_ID.eq(comunidad.get().getId()) : Criteria.EMPTY;

        return listWhere(eventoCriteria.and(nombreCriteria.and(apellidoCriteria.and(localidadCriteria.and(nivelCriteria).and(comunidadCriteria)))))
                .join(EVENTO, ASISTENTE_JORNADA_PENTECOSTES.EVENTO_ID.eq(EVENTO.ID))
                .join(ASISTENTE, ASISTENTE_JORNADA_PENTECOSTES.PERSONA_ID.eq(ASISTENTE.ID))
                .orderBy(ASISTENTE.APELLIDO, ASISTENTE.NOMBRE)
                .toList();
    }

    /** Invoked when button(resetear) is clicked */
    @Override @NotNull public Action resetearFiltros() {
        getAsistentesJornadaPentecostes().clear();
        loadAsistentes();
        return actions.getStay();
    }

    @NotNull
    @Override
    public Action addAsistencia() {
        final AsistenteJornadaPentecostesForm form = forms.initialize(AsistenteJornadaPentecostesForm.class);
        form.setEvento(getEvento());
        return actions().navigate(form).callback(AsistenciaFormMapping.class);
    }

    public class AsistentesJornadaPentecostesRow extends AsistentesJornadaPentecostesRowBase {
        @Override
        public void populate(@NotNull AsistenteJornadaPentecostes asistenteJornadaPentecostes) {
            super.populate(asistenteJornadaPentecostes);
            setIdEvento(asistenteJornadaPentecostes.getEvento().getId());
            setIdPersona(asistenteJornadaPentecostes.getPersona().getId());
            setNombre(asistenteJornadaPentecostes.getPersona().getNombre());
            setApellido(asistenteJornadaPentecostes.getPersona().getApellido());
            setEdad(String.valueOf(current().yearsFrom(asistenteJornadaPentecostes.getPersona().getFechaNacimiento())) + " años");
            setNivel(asistenteJornadaPentecostes.getPersona().getNivel());
            setComunidad(asistenteJornadaPentecostes.getPersona().getComunidad());
            setTelefono(asistenteJornadaPentecostes.getPersona().getTelefonoDeContacto());
            setContribucion(asistenteJornadaPentecostes.getMontoContribucion().compareTo(BigDecimal.ZERO) > 0);
            setPersonasACargo(asistenteJornadaPentecostes.getPersonasRelacionadas().size());
        }

        @NotNull
        @Override
        public Action editarPersona() {
            final AsistentesJornadaPentecostesRow current = getAsistentesJornadaPentecostes().getCurrent();
            return actions().navigate(AsistenteForm.class, String.valueOf(current.getIdPersona())).callback(PersonaFormMapping.class);

        }

        @NotNull
        @Override
        public Action editarAsistencia() {
            final AsistentesJornadaPentecostesRow current = getAsistentesJornadaPentecostes().getCurrent();
            final AsistenteJornadaPentecostes asistenteJornadaPentecostes = AsistenteJornadaPentecostesBase.find(getEvento().getId(), current.getIdPersona());
            return actions().navigate(AsistenteJornadaPentecostesForm.class, asistenteJornadaPentecostes.keyAsString()).callback(AsistenciaFormMapping.class);
        }
    }

    @Override
    public void loadAsistentes() {
        buscar();
    }

    public static class PersonaFormMapping implements MappingCallback<AsistenteForm, AsistenteJornadaPentecostesFormListing> {
        @Override
        public void onSave(@NotNull AsistenteForm base, @NotNull AsistenteJornadaPentecostesFormListing out) {
            if(out.isFilterPresent()){
                out.buscar();
            } else {
                out.getAsistentesJornadaPentecostes().clear();
                out.loadAsistentes();
            }
        }
    }

    public static class AsistenciaFormMapping implements MappingCallback<AsistenteJornadaPentecostesForm, AsistenteJornadaPentecostesFormListing> {
        @Override
        public void onDelete(@NotNull AsistenteJornadaPentecostesForm base, @NotNull AsistenteJornadaPentecostesFormListing out) {
            search(out);
        }

        @Override
        public void onSave(@NotNull AsistenteJornadaPentecostesForm base, @NotNull AsistenteJornadaPentecostesFormListing out) {
            search(out);
        }

        private void search(final AsistenteJornadaPentecostesFormListing out) {
            if(out.isFilterPresent()){
                out.buscar();
            } else {
                out.getAsistentesJornadaPentecostes().clear();
                out.loadAsistentes();
            }
        }
    }
}
