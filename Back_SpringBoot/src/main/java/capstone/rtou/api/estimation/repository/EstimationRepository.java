package capstone.rtou.api.estimation.repository;

import capstone.rtou.domain.estimation.Estimations;
import capstone.rtou.domain.estimation.EstimationsId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.util.List;

@Repository
public interface EstimationRepository extends JpaRepository<Estimations, EstimationsId> {
    List<Estimations> findAllById_UserIdOrderByDate(String userId);
}
