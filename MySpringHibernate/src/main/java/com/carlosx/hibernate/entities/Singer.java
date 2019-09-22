package com.carlosx.hibernate.entities;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
//import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Version;

@SuppressWarnings("serial")
@Entity
@Table(name = "SINGER")
@NamedQueries({
		@NamedQuery(name = "Singer.findById", query = "select distinct s from Singer s " + "left join fetch s.albums a "
				+ "left join fetch s.instruments i " + "where s.id = :id"),
		@NamedQuery(name = "Singer.findAllWithAlbum", query = "select distinct s from Singer s "
				+ "left join fetch s.albums a " + "left join fetch s.instruments i") })
public class Singer implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private Long id;
	@Column(name = "FIRST_NAME")
	private String firstName;
	@Column(name = "LAST_NAME")
	private String lastName;
	@Temporal(TemporalType.DATE)
	@Column(name = "BIRTH_DATE")
	private Date birthDate;
	@Version
	@Column(name = "VERSION")
	private Integer version;
	// mappedBy is the property in the Album class, in this case the property singer
	// (it could have other name)
	@OneToMany(mappedBy = "singer", cascade = CascadeType.ALL, orphanRemoval = true/* , fetch = FetchType.EAGER */)
	private Set<Album> albums = new HashSet<Album>();
	// usually you never set a fetch as EAGER as it surely affect performance!!!!
	@ManyToMany /* (fetch = FetchType.EAGER) */
	@JoinTable(name = "SINGER_INSTRUMENT", joinColumns = @JoinColumn(name = "SINGER_ID"), inverseJoinColumns = @JoinColumn(name = "INSTRUMENT_ID"))
	private Set<Instrument> instruments = new HashSet<Instrument>();

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public Date getBirthDate() {
		return birthDate;
	}

	public void setBirthDate(Date birthDate) {
		this.birthDate = birthDate;
	}

	@Version
	public Integer getVersion() {
		return version;
	}

	public void setVersion(Integer version) {
		this.version = version;
	}

	public String toString() {
		return "Singer Id:" + this.id + ", first_name:" + this.firstName + ", last_name:" + this.lastName
				+ ", birth_date:" + this.birthDate + ", version:" + this.version;
	}

	public Set<Album> getAlbums() {
		return albums;
	}

	public void setAlbums(Set<Album> albums) {
		this.albums = albums;
	}

	public Set<Instrument> getInstruments() {
		return instruments;
	}

	public void setInstruments(Set<Instrument> instruments) {
		this.instruments = instruments;
	}
	
	public void addAlbum (Album album) {
		album.setSinger(this); //if we dont add this we get not null exception when cascade saving singer
		this.albums.add(album);
	}

}
