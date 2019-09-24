package com.carlosx.myJpa.service;

import java.util.List;

import com.carlosx.myJpa.entities.Singer;
import com.carlosx.myJpa.view.SingerSummary;

public interface SingerService {
    public List<Singer> findAll();
    public List<Singer> findAllWithAlbum();
    public Singer findById(Long id);
    public Singer save (Singer singer);
    public void delete (Singer singer);
    public List<Singer> findAllByNativeQuery ();
    public List<Singer> findAllByNativeQueryAndResulSetMapping ();
    public List<Object[]> displayAllSingerSummary();
    public List<SingerSummary> displayAllSingerSummaryUsingView();
}
