package com.ticket.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.ticket.entity.File;

@Repository
public interface FileRepository extends CrudRepository<File, Integer>{
	
	List<File> findByMid(Integer id);
	
}
