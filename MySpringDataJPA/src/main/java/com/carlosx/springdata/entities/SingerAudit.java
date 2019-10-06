package com.carlosx.springdata.entities;

import java.io.Serializable;
import java.util.Date;
import java.util.Optional;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Version;

import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

@SuppressWarnings("serial")
@Entity
@EntityListeners(AuditingEntityListener.class) //Registers this class to be audited
@Table(name = "singer_audit")
/**
 * As you can see, the properties createdDate, createdBy, lastModifiedBy, lastModifiedDate are common to all tables that require audit
 * In this case we are assuming that only Singer class is being audited. In case we want to audit several tables, adding the mentioned
 * properties would be repetitive, for that case we can create a class as follows
 * @MappedSuperclass
 * @EntityListeners(AuditingEntityListener.class)
 * public abstract AuditableEntity<U> implements Serializable { 
 * Add common properties with the same mapping annotations
 * And then SingerAudit would be:
 * @Entity
 * @Table(name="singer_audit")
 * public class SingerAudit extends AuditableEntity<SingerAudit>
 * and then only Singer specific properties would be declared. This would greatly simplify the code
 * 
 * Understand that this table replaces Singer (we could have created a Singer class with the audit data). In other words 
 * this class is not additional to the Singer, this is the new Singer with audit data.
 * @author peca7004
 *
 */
public class SingerAudit implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private Long id;
	@Version
	@Column(name = "version")
	private int version;
	@Column(name = "FIRST_NAME")
	private String firstName;
	@Column(name = "LAST_NAME")
	private String lastName;
	@Temporal(TemporalType.DATE)
	@Column(name = "birth_date")
	private Date birthDate;
	@CreatedDate
	@Column(name = "CREATED_DATE")
	@Temporal(TemporalType.TIMESTAMP)
	private Date createdDate;
	@CreatedBy
	@Column(name = "CREATED_BY")
	private String createdBy;
	@LastModifiedBy
	@Column(name = "LAST_MODIFIED_BY")
	private String lastModifiedBy;
	@LastModifiedDate
	@Column(name = "LAST_MODIFIED_DATE")
	@Temporal(TemporalType.TIMESTAMP)
	private Date lastModifiedDate;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public int getVersion() {
		return version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public Date getBirthDate() {
		return birthDate;
	}

	public void setBirthDate(Date birthDate) {
		this.birthDate = birthDate;
	}

	public Optional<Date> getCreatedDate() {
		return Optional.of(createdDate);
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public Optional<String> getCreatedBy() {
		return Optional.of(createdBy);
	}

	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	public Optional<String> getLastModifiedBy() {
		return Optional.of(lastModifiedBy);
	}

	public void setLastModifiedBy(String lastModifiedBy) {
		this.lastModifiedBy = lastModifiedBy;
	}

	public Optional<Date> getLastModifiedDate() {
		return Optional.of(lastModifiedDate);
	}

	public void setLastModifiedDate(Date lastModifiedDate) {
		this.lastModifiedDate = lastModifiedDate;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String toString() {
		return "Singer - Id: " + id + ", First name: " + firstName + ", Last name: " + lastName + ", Birthday: "
				+ birthDate + ", Created by: " + createdBy + ", Create date: " + createdDate + ", Modified by: "
				+ lastModifiedBy + ", Modified date: " + lastModifiedDate;
	}
}
