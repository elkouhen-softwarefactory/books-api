package com.softeam.books.dao;

import com.softeam.books.dto.BookDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import java.util.Collection;

@Component
public class BookDAO {

    private static final String SELECT_FROM_T_BOOK = "SELECT * FROM T_BOOK";

    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public BookDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public Collection<BookDTO> findAll() {
        return jdbcTemplate.query(SELECT_FROM_T_BOOK, (resultSet, i) -> new BookDTO(resultSet.getInt("ID"), resultSet.getString("TITLE")));
    }
}
