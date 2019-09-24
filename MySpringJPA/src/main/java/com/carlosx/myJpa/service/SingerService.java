package com.carlosx.myJpa.service;

import java.util.List;

import com.carlosx.myJpa.entities.Singer;

public interface SingerService {
    List<Singer> findAll();
    List<Singer> findaAllWithAlbum();
    Singer findById(Long id);
    Singer save (Singer singer);
    void delete (Singer singer);
    List<Singer> findAllByNativeQuery ();
}
