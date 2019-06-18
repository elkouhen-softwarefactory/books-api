package com.ippon.books.dao;

import com.ippon.books.dto.BookDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;

@Component
public class BookDAO {

    private static final String SELECT_FROM_T_BOOK = "SELECT * FROM T_BOOK";

    private static final String TITLE = "TITLE";
    private static final String ID = "ID";
    private static final String AUTHORS = "AUTHORS";

    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public BookDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public Collection<BookDTO> findAll() {
        return jdbcTemplate.query(SELECT_FROM_T_BOOK, this::mapRow);
    }

    private BookDTO mapRow(ResultSet resultSet, int i) throws SQLException {
        return new BookDTO(resultSet.getInt(ID), resultSet.getString(TITLE), resultSet.getString(AUTHORS));
    }
}

