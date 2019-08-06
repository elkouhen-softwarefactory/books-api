package com.ippon.books.resources;

import com.ippon.books.dao.BookDAO;
import com.ippon.books.dto.BookDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collection;


@RestController
public class BookResource {

    private final Logger logger = LoggerFactory.getLogger(BookResource.class);

    private final BookDAO bookDAO;

    @Autowired
    public BookResource(BookDAO bookDAO) {
        this.bookDAO = bookDAO;
    }

    @GetMapping(path = "/books")
    public Collection<BookDTO> books() {

        logger.info("@GetMapping /books called -- API 7 !");

        return bookDAO.findAll();  
    }
}
