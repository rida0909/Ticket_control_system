package com.ticket.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.ticket.entity.Request;

@Repository
public interface RequestRepository extends CrudRepository<Request, Integer> {

List<Request> getByUser(Integer assigned);
	
	@Query(value = "SELECT r from Request r where r.status = :status")
	List<Request> requestByStatus(String status);
	
	@Query(value = "Select r.* from Request r where r.date between ?1 and ?2", nativeQuery = true)
	List<Request> requestByFromDateTo(Date fromDate, Date toDate);
	@Query(value = "Select r.* from Request r where r.date between ?1 and (select max(date) from Request)", nativeQuery = true)
	List<Request> requestByFromDate(Date fromDate);
	@Query(value = "Select r.* from Request r where r.date between (select min(date) from Request) and ?1", nativeQuery = true)
	List<Request> requestByToDate(Date toDate);
	
	List<Request> getByType(String issueType);
	List<Request> getByCategory(String issueCategory);
	List<Request> getBycid(Integer cid);
	
}
