package org.oztrack.app;

import java.util.Date;

public interface OzTrackOaiPmhConfiguration {
    boolean isOaiPmhEnabled();
    String getOaiPmhIdentifierPrefix();
    String getObjectIdentifierPrefix();
    String getRifCsGroup();
    String getRepositoryCreator();
    String getRepositoryServiceTitle();
    String getRepositoryServiceDescription();
    Date getRepositoryServiceCreateDate();
    Date getRepositoryServiceUpdateDate();
    String getOaiPmhServiceTitle();
    String getOaiPmhServiceDescription();
    Date getOaiPmhServiceCreateDate();
    Date getOaiPmhServiceUpdateDate();
    String getOaiPmhServiceAdminEmail();
    String getRepositoryCollectionTitle();
    String getRepositoryCollectionDescription();
    Date getRepositoryCollectionCreateDate();
    Date getRepositoryCollectionUpdateDate();
}