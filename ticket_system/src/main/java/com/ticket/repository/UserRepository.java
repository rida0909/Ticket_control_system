package com.ticket.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.ticket.entity.User;

@Repository
public interface UserRepository extends CrudRepository<User, Integer>{

	User getByUsername(String name);

	List<User> findByRole(String role);
	
	//@Query("select D from User D where D.username=:name ")
	//List<User> getUserByName(String name);

}
