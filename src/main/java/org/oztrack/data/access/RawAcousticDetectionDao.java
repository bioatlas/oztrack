package org.oztrack.data.access;

import au.edu.uq.itee.maenad.dataaccess.Dao;
import org.oztrack.data.model.RawAcousticDetection;

/**
 * Created by IntelliJ IDEA.
 * User: uqpnewm5
 * Date: 13/04/11
 * Time: 1:12 PM
 * To change this template use File | Settings | File Templates.
 */
public interface RawAcousticDetectionDao extends Dao<RawAcousticDetection> {

    int getNumberDetections();
//    java.util.Date getMinDetectionDate();
//    java.util.Date getMaxDetectionDate();
//    int [] getAllAnimalIds();
//    int [] getAllReceiverIds();

}